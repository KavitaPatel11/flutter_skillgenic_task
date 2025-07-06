import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> initialize() async {
    // Timezone initialization
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await _notificationsPlugin.initialize(initSettings);
  }

  // Request notification permissions (for Android 13+)
  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      await Permission.notification.request();
    }
  }

  // Schedule notification
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleDate,
  }) async {
    if (scheduleDate.isBefore(DateTime.now())) return; // Avoid scheduling in the past

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel',
          'Task Notifications',
          channelDescription: 'Reminder for scheduled tasks',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  // Cancel a notification by id
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}
