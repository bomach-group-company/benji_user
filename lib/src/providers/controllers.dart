import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji/app/home/home.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      null,
      [
        NotificationChannel(
          channelGroupKey: "high_importance_channel_group",
          channelKey: "high_importance_channel",
          channelName: "Basic Notifications",
          channelDescription: "Channel for testing",
          channelShowBadge: true,
          defaultColor: kPrimaryColor,
          ledColor: kAccentColor,
          enableVibration: true,
          enableLights: true,
          importance: NotificationImportance.High,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "high_importance_channel_group",
          channelGroupName: "Group 1",
        ),
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreateMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreateMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreateMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayMethod");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onDismissActionReceivedMethod");
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onActionReceiveMethod");
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => const Home(),
        ),
      );
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "high_importance_channel",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            )
          : null,
    );
  }
}
