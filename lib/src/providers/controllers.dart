import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/home/home.dart';
import '../../main.dart';
import '../../theme/colors.dart';

class LatLngDetailController extends GetxController {
  var latLngDetail = [].obs;
  setLatLngdetail(List latLngDetailList) {
    for (var i in latLngDetailList) {
      latLngDetail.add(i ?? '');
    }
  }

  setEmpty() {
    latLngDetail.removeRange(0, latLngDetail.length);
    latLngDetail.addAll(['', '', '']);
  }
}

bool isNotificationEnabled() {
  bool? status = prefs.getBool('isNotificationEnabled');
  return status ?? false;
}

Future<bool> setNotificationStatus(bool status) async {
  await prefs.setBool('isNotificationEnabled', status);
  return status;
}

class NotificationController {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelGroupKey: "basic_channel_group",
          channelName: "Basic Notifications",
          channelDescription: "Channel for basic notifications",
          channelShowBadge: true,
          defaultColor: kPrimaryColor,
          ledColor: kAccentColor,
          enableVibration: true,
          enableLights: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          vibrationPattern: lowVibrationPattern,
          importance: NotificationImportance.High,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "basic_channel_group",
          channelGroupName: "Basic group",
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

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    MyApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => const Home(),
      ),
    );
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

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onDismissActionReceivedMethod");
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
    final bool repeats = false,
    final bool allowWhileIdle = true,
    final bool preciseAlarm = false,
    final String icon = "",
    final bool criticalAlert = false,
    final String customSound = "",
    final String largeIcon = "",
    final bool hideLargeIconOnExpand = true,
    final bool roundedBigPicture = false,
    final bool roundedLargeIcon = false,
    final bool autoDismissible = true,
    final Color? color,
    final bool showWhen = true,
    final bool displayOnBackground = true,
    final bool displayOnForeground = true,
    final bool wakeUpScreen = true,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: "basic_channel",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
        color: color,
        icon: icon,
        criticalAlert: criticalAlert,
        customSound: customSound,
        largeIcon: largeIcon,
        hideLargeIconOnExpand: hideLargeIconOnExpand,
        roundedBigPicture: roundedBigPicture,
        roundedLargeIcon: roundedLargeIcon,
        autoDismissible: autoDismissible,
        showWhen: showWhen,
        displayOnBackground: displayOnBackground,
        displayOnForeground: displayOnForeground,
        wakeUpScreen: wakeUpScreen,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              repeats: repeats,
              allowWhileIdle: allowWhileIdle,
              preciseAlarm: preciseAlarm,
            )
          : null,
    );
  }


}
