import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails()
      );
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  final scheduledDate = tz.TZDateTime(
    tz.local,
    2023, // Año
    10,   // Mes
    17,   // Día
    16,   // Hora
    23,    // Minuto
  );

  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // ID de la notificación
    'Título de la notificación',
    'Cuerpo de la notificación',
    scheduledDate,
    platformChannelSpecifics,
    // ignore: deprecated_member_use
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

}
