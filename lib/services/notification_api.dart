import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    // store android and ios notification settings in a variable
    const android = AndroidInitializationSettings('ic_notification');
    const ios = IOSInitializationSettings();
    // initialize notification settings
    const initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(initializationSettings);
    // initialize time zone
    tz.initializeTimeZones();
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(
        id,
        title,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails('channelId', 'channelName',
                importance: Importance.max, icon: 'ic_notification'),
            iOS: IOSNotificationDetails()),
        payload: payload);
  } //show notificatin

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDateTime,
  }) async {
    _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDateTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails('channelId', 'channelName',
                importance: Importance.max, icon: 'ic_notification'),
            iOS: IOSNotificationDetails()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  static Future removeSchedules(int notificationId) async {
    _notifications.cancel(notificationId);
  } //remove schedule

}// notofication api
