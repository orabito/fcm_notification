/*
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalService {
  // Initialize notifications plugin
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Notification Channel Configuration (Android 8.0+)
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // Unique channel ID
    'High Importance Notifications', // User-visible name
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound'),
  );

  static Future<void> init() async {
    // Request notification permissions (Android 13+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Platform-specific initialization settings
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        print('Notification tapped!');
      },
    );

    // Create notification channel (Android 8.0+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Initialize time zones once
    tz.initializeTimeZones();
  }

  // Helper function for notification details
  static const NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Colors.blue,
      enableLights: true,
      ledColor: Colors.red,
      ledOnMs: 1000,
      ledOffMs: 500,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // Basic Notification
  static Future<void> showBasicNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello!',
      'This is a notification from Flutter',
      _notificationDetails,
      payload: 'notification_payload',
    );
  }

  // Repeated Notification
  static Future<void> showRepeatedNotification() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Hello, this is Repeated',
      'This is a Repeated notification from Flutter',
      RepeatInterval.everyMinute,
      _notificationDetails,
      payload: 'notification_payload',
    );
  }

  // Scheduled Notification
  static Future<void> showScheduleNotification() async {
    final scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Hello, this is schedule',
      'This is a schedule notification from Flutter',
      scheduledTime,
      _notificationDetails,
      payload: 'notification_payload',
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}*/
