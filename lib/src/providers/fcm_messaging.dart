import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleFCMBackgroundMessaging() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print("This is the FCM token: $fcmToken");
  }
  FirebaseMessaging.onBackgroundMessage((message) {
    return _firebasePushHandler(message);
  });

  //When the app restarts
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    if (kDebugMode) {
      print("This is the FCM token: $fcmToken");
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

Future<void> _firebasePushHandler(RemoteMessage message) {
  debugPrint("Message from push notification is $message.data");
  return AwesomeNotifications().createNotificationFromJsonData(message.data);
}
