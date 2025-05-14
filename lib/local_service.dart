import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalService {
  // Initialize notifications plugin instance
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Main notification channel (high importance)
  static const AndroidNotificationChannel _mainChannel = AndroidNotificationChannel(
    'high_importance_channel', // Unique channel ID
    'High Importance Notifications', // User-visible name
    description: 'This channel is used for important notifications.', // Channel description
    importance: Importance.max, // Maximum priority (heads-up notifications)
    playSound: true,
    sound: RawResourceAndroidNotificationSound('sound2'), // Default sound from Android raw resources
  );

  // Dedicated channel for repeated notifications
  static const AndroidNotificationChannel _repeatedChannel = AndroidNotificationChannel(
    'repeated_channel', // Unique channel ID
    'Repeated Notifications', // User-visible name
    description: 'This channel is used for repeated notifications.', // Channel description
    importance: Importance.high, // High priority (not heads-up)
    playSound: true,
    sound: UriAndroidNotificationSound('assets/sound/sondfor.mp3'), // Custom sound from assets
  );

  static Future<void> init() async {
    // Clean up existing channels to avoid conflicts
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(_mainChannel.id);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(_repeatedChannel.id);

    // Request notification permissions (Android 13+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Platform-specific initialization settings
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'), // App icon for notifications
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true, // Request alert permission (iOS)
        requestBadgePermission: true, // Request badge permission (iOS)
        requestSoundPermission: true, // Request sound permission (iOS)
      ),
    );

    // Initialize notifications plugin
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        log('Notification tapped!'); // Handle notification taps
      },
    );

    // Create Android notification channels
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_mainChannel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_repeatedChannel);
  }

  // Basic notification with default sound
  static Future<void> showBasicNotification() async {
    // Android-specific configuration
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound("sound2"), // Default sound
      playSound: true,
      enableVibration: true,
      color: Colors.blue, // Accent color
      ledColor: Colors.red, // LED color
      ledOnMs: 1000, // LED on duration (milliseconds)
      ledOffMs: 500, // LED off duration (milliseconds)
    );

    // Platform-agnostic notification details
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true, // Show alert (iOS)
        presentBadge: true, // Update badge (iOS)
        presentSound: true, // Play sound (iOS)
        sound: 'sound2.caf', // iOS sound file name (CAF format)
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Hello!', // Title
      'This is a notification from Flutter', // Body
      details,
      payload: 'notification_payload', // Optional payload
    );
  }

  // Repeating notification with custom sound
  static Future<void> showRepeatedNotification() async {
    // Android-specific configuration for repeated notifications
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'repeated_channel', // Correct channel ID
      'Repeated Notifications',
      channelDescription: 'This channel is used for repeated notifications.',
      importance: Importance.high,
      priority: Priority.high,
      sound: UriAndroidNotificationSound('assets/sound/sondfor.mp3'), // Full asset path
      playSound: true,
    );

    // Platform-agnostic notification details
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'soundfor.caf', // iOS sound file (converted to CAF format)
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1, // Notification ID
      'Hello , this is Repeated', // Title
      'This is a Repeated notification from Flutter', // Body
      RepeatInterval.everyMinute, // Repeat interval
      details,
      payload: 'notification_payload',
    );
  }

  // Scheduled notification with default sound
  static Future<void> showScheduleNotification() async {
    // Initialize timezone database
    tz.initializeTimeZones();

    // Get device timezone
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Schedule after 10 seconds (for testing)
    final scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    // Android-specific configuration
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound("sound2"), // Default sound
      playSound: true,
    );

    // Platform-agnostic notification details
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'sound2.caf', // iOS sound file name
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2, // Notification ID
      'Hello , this is schedule', // Title
      'This is a schedule notification from Flutter', // Body
      scheduledTime, // Scheduled time
      details,
      payload: 'notification_payload',
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime, // iOS time handling
    );
  }

  // Cancel specific notification by ID
  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}