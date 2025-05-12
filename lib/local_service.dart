import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalService {
  // Initialize notifications plugin
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // Notification Channel Configuration (Android 8.0+)
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',// Unique channel ID
    'High Importance Notifications',// User-visible name
    description: 'This channel is used for important notifications.',  // Channel description in settings
    importance: Importance.max,// Maximum priority (heads-up notification)
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
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'high_importance_channel', // Same channel ID
      'High Importance Notifications',// Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,// Maximum importance
      priority: Priority.high,// High priority
      ticker: 'ticker',// Text that appears in status bar
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
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'high_importance_channel 2', // Same channel ID
      'High Importance Notifications',// Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,// Maximum importance
      priority: Priority.high,// High priority
      ticker: 'ticker',// Text that appears in status bar
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

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Hello , this is Repeated',
      'This is a Repeated notification from Flutter',
      RepeatInterval.weekly,
      details,
      payload: 'notification_payload',
    );
  }
static  Future<void> cancelNotification(int id) async {
 await flutterLocalNotificationsPlugin.cancel(id);

  }
}