import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class LatLngDetailController extends GetxController {
  var latLngDetail = [].obs;
  setLatLngdetail(List latLngDetailList) {
    for (var i in latLngDetailList) {
      latLngDetail.add(i ?? '');
    }
  }

  setEmpty() {
    latLngDetail.removeRange(0, latLngDetail.length);
    if (kDebugMode) {
      print(latLngDetail);
    }
    latLngDetail.addAll([]);
  }
}

//
bool isNotificationEnabled() {
  bool? status = prefs.getBool('isNotificationEnabled');
  if (kDebugMode) {
    print('the status of isNotificationEnabled is --- $status');
  }
  return status ?? false;
}

Future<bool> setNotificationStatus(bool status) async {
  await prefs.setBool('isNotificationEnabled', status);
  if (kDebugMode) {
    print('the status is $status');
  }
  return status;
}

class NotificationController {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      "assets/images/logo/benji_blue_logo_icon.jpg",
      [
        NotificationChannel(
          channelKey: "high_importance_channel",
          channelGroupKey: "high_importance_channel",
          channelName: "Basic Notifications",
          channelDescription: "Channel for testing",
          channelShowBadge: true,
          defaultColor: kPrimaryColor,
          ledColor: kAccentColor,
          enableVibration: true,
          enableLights: true,
          icon: FontAwesomeIcons.solidBell.toString(),
          importance: NotificationImportance.High,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "high_importance_group_channel",
          channelGroupName: "Group 1",
        ),
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed();
  }
}
