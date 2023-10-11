import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleFCM() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();

  if (kDebugMode) {
    print("This is the FCM token: $fcmToken");
  }

  // FirebaseMessaging.onBackgroundMessage(
  //     (message) => _firebasePushHandler(message));
  //When the app restarts
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    if (kDebugMode) {
      print("This is the FCM token after the app restarted: $fcmToken");
    }
    FirebaseMessaging.onBackgroundMessage((message) {
      return _firebasePushHandler(message);
    });
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    if (kDebugMode) {
      print("This is the error: $err");
    }
    // Error getting token.
  });
}

_firebasePushHandler(RemoteMessage message) {
  debugPrint("Message from push notification is $message.data");
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
