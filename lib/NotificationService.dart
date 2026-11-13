import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level background handler for FCM messages when app is in background or terminated.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('🔥 [FCM Background Message]: ${message.messageId}');
    print('🔥 Title: ${message.notification?.title}');
    print('🔥 Body: ${message.notification?.body}');
    print('🔥 Data: ${message.data}');
  }
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important push notifications.',
    importance: Importance.high,
    playSound: true,
  );

  /// Initializes permissions, FCM listeners, and local notifications
  static Future<void> initialize() async {
    // 1. Request Notification Permissions (Android 13+ & iOS)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (kDebugMode) {
      print('🔥 Notification permission status: ${settings.authorizationStatus}');
    }

    // 2. Setup Android Local Notifications
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
    InitializationSettings(android: androidInit, iOS: iosInit);


    // Create High Importance Android Notification Channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    // 3. Set foreground notification presentation options
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 4. Get FCM Device Token
    try {
      final token = await _messaging.getToken();
      if (kDebugMode) {
        print('====================================================');
        print('🔥 FCM DEVICE TOKEN:');
        print('$token');
        print('====================================================');
      }
    } catch (e) {
      if (kDebugMode) {
        print('🔥 Error fetching FCM token: $e');
      }
    }

    // 5. Listen to Token Refresh
    _messaging.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('🔥 FCM Token Refreshed: $newToken');
      }
      // Send this new token to your backend if needed
    });

    // 6. Handle Foreground Push Notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('🔥 [FCM Foreground Message Received]:');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');
      }
      showLocalNotification(message);
    });

    // 7. Handle when user taps notification while app is in Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('🔥 User opened app from notification: ${message.data}');
      }
      // Navigate to specific screen based on message.data if needed
    });

    // 8. Handle when user taps notification while app was completely Terminated
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      if (kDebugMode) {
        print('🔥 App launched from terminated state via notification: ${initialMessage.data}');
      }
      // Navigate to specific screen based on initialMessage.data if needed
    }
  }

  /// Displays a heads-up notification banner when the app is in the Foreground
  static void showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

  }
}

