import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FcmMessagingController extends GetxController {
  static FcmMessagingController get instance {
    return Get.find<FcmMessagingController>();
  }

  Future<void> handleFCM() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (kDebugMode) {
      print("This is the FCM token: $fcmToken");
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //When the app restarts
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      if (kDebugMode) {
        print("This is the FCM token after the app restarted: $fcmToken");
      }
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      if (kDebugMode) {
        print("This is the error: $err");
      }
      // Error getting token.
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }

    //call awesomenotification to how the push notification.
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}
