import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final notiPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await notiPlugin.initialize(settings);

    tz.initializeTimeZones(); // Required for scheduling
    tz.setLocalLocation(tz.getLocation('Asia/Singapore'));
  }

  static Future<void> scheduleReminder(DateTime busTime, int id) async {
    final location = tz.local;
    DateTime notifyTime = busTime.subtract(const Duration(minutes: 3));
    DateTime now = DateTime.now(); //added

    // Skip scheduling if user books on/after notifyTime ADDED
    if (!now.isBefore(notifyTime)) {
      print('No notification scheduled: Booking made at or after notifyTime ($notifyTime).');
      return;
    }

    Duration delay = notifyTime.difference(DateTime.now());

    const androidDetails = AndroidNotificationDetails(
      'channel_Id',
      'channel_Name',
      channelDescription: 'Reminder channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);



    if (delay.inSeconds <= 0) {
      await notiPlugin.show(
        id,
        'MooRide Bus Reminder',
        'Just 3 minutes until your bus begins its trip. Get ready!',
        platformDetails,
      );
    } else if (delay < const Duration(minutes: 1)) {
      Future.delayed(delay, () {
        notiPlugin.show(
          id,
          'MooRide Bus Reminder',
          'Just 3 minutes until your bus begins its trip. Get ready!',
          platformDetails,
        );
      });
    } else {
      await notiPlugin.zonedSchedule(
        id,
        'MooRide Bus Reminder',
        'Just 3 minutes until your bus begins its trip. Get ready!',
        tz.TZDateTime.from(notifyTime, location),
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static Future<void> cancelAll() async {
    await notiPlugin.cancelAll();
  }
}
