import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {

  final String _databaseName = "felicitime.db";
  final int _databaseVersion = 1;

  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  // 2. Base de données : Instance de la DB
  static Database? _database;

  // 3. Getter pour la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialiser la DB si elle est null
    _database = await _initDatabase();
    return _database!;
  }

  // 4. Initialisation de la base de données
  Future<Database> _initDatabase() async {
    // Obtenir le chemin de stockage de la base de données
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    // Ouvrir ou créer la base de données
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      //onUpgrade: _onUpgrade,
    );
  }

  // Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   // Gérer les mises à jour de la base de données si nécessaire
  //   if (oldVersion < 2) {
  //     // Exemple : Ajouter une nouvelle colonne
  //     // await db.execute('ALTER TABLE $tableName ADD COLUMN new_column TEXT');
  //   }
  // }

  // 5. Création de la table (appelé une seule fois lors de la première ouverture)
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE capsules (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  /*
  // Insertion
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert(tableName, row);
  }

  // Requête (Lire)
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await _instance.database;
    return await db.query(tableName);
  }

  // Requête par ID
  Future<List<Map<String, dynamic>>> queryById(String tableName, int id) async {
    Database db = await _instance.database;
    return await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mise à jour
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await _instance.database;
    int id = row[columnId];
    return await db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Suppression
  Future<int> delete(int id) async {
    Database db = await _instance.database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }*/
}