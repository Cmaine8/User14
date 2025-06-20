import 'package:flutter/material.dart';
import 'package:mini_project_five/screens/mapPage.dart';
import 'data/getData.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'services/notifications.dart';  // update path as needed



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  // Permission
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  const platform = MethodChannel('dexterous.com/flutter/local_notifications');
  try {
    final bool canSchedule = await platform.invokeMethod('canScheduleExactNotifications');
    if (!canSchedule) {
      await platform.invokeMethod('requestExactAlarmsPermission');
    }
  } catch (_) {}
  await BusData().loadData();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  void onThemeChanged(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/home',
      routes: {
      '/home' : (context) => Map_Page(),
      },
    );
  }
}
