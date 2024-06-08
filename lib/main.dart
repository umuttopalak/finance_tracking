import 'dart:io' show Platform;

import 'package:finance_tracking/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureFirebaseMessaging(); // Firebase Messaging yapılandırmasını çağır
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Key düzeltmesi

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
  // Firebase Messaging yapılandırmasını burada yapın
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Bildirim izni iste ve kullanıcının izin verip vermediğini kontrol et
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true, // Provisional izinleri burada ayarlayın
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Uygulama ön planda olduğunda gelen bildirimleri dinle
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // Platforma göre farklı işlemleri yap
  if (kIsWeb) {
    // Web platformu için özel işlemleri buraya ekleyin
    final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BLen8Yp-6U5MlpfKkb2ftwmLZ2R4ILRLscsFtuH5BaFQTPaCqtlWbBgJqu05qKJ-Jh6pYyFYjnLlulRm66qG0HY");

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((err) {});
  } else if (Platform.isIOS || Platform.isAndroid) {
    // iOS ve Android platformları için özel işlemleri buraya ekleyin
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {}
    }
  }
}
