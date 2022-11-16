import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PushNotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage event) async {
    if (event.notification != null) {
      if (event.data["channelId"] == "scheduleNotification") {
        _showScheduleNotification(
            event.notification!,
            Timestamp.fromMillisecondsSinceEpoch(int.parse(event.data['time']))
                .toDate()
                .subtract(const Duration(minutes: 30)),
            event.data['doctor']);
      }
    }
  }

  static Future init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _fcm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission();
      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }
    } else if (Platform.isAndroid) {
      _createNotificationChannel("scheduleNotification",
          "Schedule Notification", "schedule Notification is for reminder");
      _createNotificationChannel("updateNotification", "Update Notification",
          "update Notification is for reminder");
    }
    var android = const AndroidInitializationSettings("drawable/logo");
    var ios = const IOSInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    FirebaseMessaging.onMessage.listen((event) async {
      if (event.notification != null) {
        if (event.data["channelId"] == "scheduleNotification") {
          _showUpdateNotification(event.notification!);
          _showScheduleNotification(
              event.notification!,
              Timestamp.fromMillisecondsSinceEpoch(
                      int.parse(event.data['time']))
                  .toDate()
                  .subtract(const Duration(minutes: 30)),
              event.data['doctor']);
        } else {
          _showUpdateNotification(event.notification!);
        }
      }
    });
  }

  //create notification channels
  static Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    var androidNotificationChannel = AndroidNotificationChannel(id, name,
        description: description, importance: Importance.max);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  static void _showUpdateNotification(RemoteNotification message) async {
    var android = const AndroidNotificationDetails(
        "updateNotification", "Update Notification",
        autoCancel: true);
    var ios = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(9999),
      message.title,
      message.body,
      platform,
    );
  }

  static void _showScheduleNotification(
      RemoteNotification message, DateTime timestamp, String doctorName) async {
    if (_checkDate(timestamp)) {
      tz.initializeTimeZones();
      final String? timeZoneName =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName!));
      var android = const AndroidNotificationDetails(
          "scheduleNotification", "scheduleNotification",
          autoCancel: false);
      var ios = const IOSNotificationDetails();
      var platform = NotificationDetails(android: android, iOS: ios);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          Random().nextInt(9999),
          "Appointment Reminder",
          "Reminder of appointment with " + doctorName,
          _nextInstanceTime(timestamp),
          platform,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static tz.TZDateTime _nextInstanceTime(DateTime timestamp) {
    final date = tz.TZDateTime.from(timestamp, tz.local);
    return date;
  }

  static bool _checkDate(DateTime timestamp) {
    return DateTime.now().isBefore(timestamp);
  }
}
