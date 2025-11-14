class Capsule {

  int id;
  String title;
  String description;
  Duration duration;
  List<String> tags;

  Capsule({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.tags
  });

  @override
  toString() => 'User {id: $id, title: $title, description: $description}';

}