import 'dart:convert';

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
  OSNotificationPermission.provisional;
  enableNotifications(true);
}

Future<void> enableNotifications(bool value) async {
  OneSignal.Notifications.canRequest();
  OneSignal.initialize(oneSignalAppID);
  OneSignal.consentGiven(value);
  OSNotificationPermission.authorized;
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    OSNotificationDisplayType.notification;
  });
}

Future<void> disableNotifications(bool value) async {
  OneSignal.consentRequired(value);
  OSNotificationPermission.denied;
  OneSignal.Notifications.clearAll();
  OneSignal.Notifications.removeForegroundWillDisplayListener((event) {
    OSNotificationDisplayType.none;
  });
}

Future<bool> isNotificationEnabled(bool status) async {
  await prefs.setBool('isNotificationEnabled', status);
  return status;
}
