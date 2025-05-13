/*
* import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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
    // Channel description in settings
    importance: Importance.max,
    // Maximum priority (heads-up notification)
    playSound: true,
    // Custom sound from res/raw/notification_sound.mp3
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
        requestAlertPermission: true, // Request alert permission
        requestBadgePermission: true, // Request badge permission
        requestSoundPermission: true, // Request sound permission
      ),
    );

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      // Handle notification taps
      onDidReceiveNotificationResponse: (response) {
        print('Notification tapped!');
      },
    );
// Create notification channel (Android 8.0+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  // Android-specific notification details &&basic function
  static Future<void> showBasicNotification() async {
    //use it in details
     AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Same channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      // Maximum importance
      priority: Priority.high,
      // High priority
      ticker: 'ticker',
      // Text that appears in status bar
      color: Colors.blue,
      enableLights: true,
      ledColor: Colors.red,
      ledOnMs: 1000,
      ledOffMs: 500,
      sound: RawResourceAndroidNotificationSound("soundfor")
    );
    // Platform-independent notification details
     NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS:const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello!',
      'This is a notification from Flutter',
      details,
      payload: 'notification_payload',

    );
  }

  //repeated function
  static Future<void> showRepeatedNotification() async {
    //use it in details
     AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Same channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      // Maximum importance
      priority: Priority.high,
      // High priority
      ticker: 'ticker',
      // Text that appears in status bar
      color: Colors.blue,
      enableLights: true,
      ledColor: Colors.red,
      ledOnMs: 1000,
      ledOffMs: 500,
            sound: RawResourceAndroidNotificationSound("sound2")

        );
    // Platform-independent notification details
     NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS:const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        'Hello , this is Repeated',
        'This is a Repeated notification from Flutter',
        RepeatInterval.everyMinute,
        details,
        payload: 'notification_payload');
  }

  //schedule function
  static Future<void> showScheduleNotification() async {
    //use it in details
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Same channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      // Maximum importance
      priority: Priority.high,
      // High priority
      ticker: 'ticker',
      // Text that appears in status bar
      color: Colors.blue,
      enableLights: true,
      ledColor: Colors.red,
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    // Platform-independent notification details
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    tz.initializeTimeZones();

    //i can handel by this way
    // tz.TZDateTime(tz.local, 2025, 5, 12, 21, 55),
    //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));


    log(tz.local.name);
    log(tz.TZDateTime.now(tz.local).hour.toString());
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final scheduledTime =
    tz.TZDateTime(tz.local, 2025, 5, 13, 15, 34);
    log(tz.local.name);
    log("before ${tz.TZDateTime.now(tz.local).hour.toString()}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Hello , this is schedule',
      'This is a schedule notification from Flutter',
      scheduledTime,
      details,
      payload: 'notification_payload',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,

    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
*/