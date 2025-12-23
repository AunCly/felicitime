import 'package:felicitime/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialisation des données de fuseau horaire (Nécessaire pour les notifications planifiées)
    tz.initializeTimeZones();

    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));

    // Configuration Android (L'icône doit être dans android/app/src/main/res/drawable)
    // Remplacez 'app_icon' par le nom de votre fichier icône (souvent 'ic_launcher' ou 'mipmap/ic_launcher')
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuration iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  Future<void> scheduleDailyMoodNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Humeur du jour',
      'Comment vous êtes-vous senti aujourd\'hui ?',
      _nextInstanceOfEighteen(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_mood_channel_id',
          'Rappel Quotidien',
          channelDescription: 'Rappel pour enregistrer son humeur quotidienne',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleCapsuleNotification() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? recurrence = prefs.getString('recurrence');
    int recurrenceDays = 7;

    if(recurrence == 'day'){
      recurrenceDays = 1;
    }
    else if(recurrence == 'month'){
      recurrenceDays = 30;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Nouvelle capsule',
      'Et si vous preniez un peu de temps pour vous ?',
      _nextInstanceOfCapsule(recurrenceDays),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_mood_channel_id',
          'Rappel pour effectuer sa capsule et prendre du temps pour soit.',
          channelDescription: '',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfEighteen() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    // Créer une date pour aujourd'hui à 20h00:00
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 00, 0);

    // Si 20h est déjà passé aujourd'hui, on programme pour demain
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfCapsule(int recurrenceDays) {

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 09, 00, 0);
    scheduledDate = scheduledDate.add(Duration(days: recurrenceDays));

    return scheduledDate;
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelMoodNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelCapsuleNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }
}