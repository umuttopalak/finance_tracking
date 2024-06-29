// ignore_for_file: unused_local_variable

import 'dart:io' show Platform;

import 'package:finance_tracking/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureFirebaseMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Finance Tracker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> configureFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
    }
  });

  if (kIsWeb) {
    final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BLen8Yp-6U5MlpfKkb2ftwmLZ2R4ILRLscsFtuH5BaFQTPaCqtlWbBgJqu05qKJ-Jh6pYyFYjnLlulRm66qG0HY");

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((err) {});
  } else if (Platform.isIOS || Platform.isAndroid) {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {}
    }
  }
}
