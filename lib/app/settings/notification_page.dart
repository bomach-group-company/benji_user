import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../src/components/button/notification_button.dart';
import '../../src/repo/controller/notifications_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Notification Screen (Awesome Notifications)",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          children: [
            NotificationButton(
              text: "Normal Notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  largeIcon: "asset://assets/icons/app_icon.png",
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Notification with summary",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  summary: "Small summary",
                  notificationLayout: NotificationLayout.Inbox,
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Progress bar notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  summary: "Small summary",
                  notificationLayout: NotificationLayout.ProgressBar,
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Message notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  summary: "Small summary",
                  notificationLayout: NotificationLayout.Messaging,
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Big image notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  summary: "Small summary",
                  notificationLayout: NotificationLayout.BigPicture,
                  bigPicture:
                      "https://files.tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg",
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Action button notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  payload: {
                    "navigate": "true",
                  },
                  customSound: "asset://assets/audio/benji.wav",
                  actionButtons: [
                    NotificationActionButton(
                      key: "check",
                      label: "Check it out",
                      actionType: ActionType.SilentAction,
                      color: kAccentColor,
                    ),
                  ],
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Scheduled notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  scheduled: true,
                  interval: 5,
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
            NotificationButton(
              text: "Another notification",
              onPressed: () async {
                await NotificationController.showNotification(
                  title: "Title of the notification",
                  body: "Body of the notification",
                  allowWhileIdle: true,
                  actionButtons: [
                    NotificationActionButton(
                      key: "open",
                      label: "Open",
                      actionType: ActionType.Default,
                      color: kSecondaryColor,
                      autoDismissible: true,
                      requireInputText: true,
                    ),
                  ],
                  customSound: "asset://assets/audio/benji.wav",
                );
              },
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
