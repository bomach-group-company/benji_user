import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../main.dart';
import '../../providers/keys.dart';
import '../models/user/user_model.dart';
import 'helpers.dart';

Future<void> loadOneSignal() async {
  User? user = await getUser();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize(oneSignalAppID);
  OneSignal.Notifications.canRequest();
  OneSignal.Notifications.requestPermission(true);
  OneSignal.User.addEmail(user!.email!);
  OneSignal.User.addSms(user.phone!);
  bool oneSignalermission = OneSignal.Notifications.permission;
  if (oneSignalermission == true) {
    if (kDebugMode) {
      print(oneSignalermission);
    }
    enableNotifications(true);
  } else {
    if (kDebugMode) {
      print(oneSignalermission);
    }
    disableNotifications(false);
  }
}

Future<void> enableNotifications(bool value) async {
  OneSignal.Notifications.canRequest();
  OneSignal.initialize(oneSignalAppID);
  OneSignal.consentGiven(value);
  OSNotificationPermission.authorized;
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    OSNotificationDisplayType.notification;
  });
  await setNotificationStatus(true);
}

Future<void> disableNotifications(bool value) async {
  OneSignal.consentRequired(value);
  OSNotificationPermission.denied;
  OneSignal.Notifications.clearAll();
  OneSignal.Notifications.removeForegroundWillDisplayListener((event) {
    OSNotificationDisplayType.none;
  });
  await setNotificationStatus(false);
}

bool isNotificationEnabled() {
  bool? status = prefs.getBool('isNotificationEnabled');
  return status ?? false;
}

Future<bool> setNotificationStatus(bool status) async {
  await prefs.setBool('isNotificationEnabled', status);
  print('the status is $status');
  return status;
}
