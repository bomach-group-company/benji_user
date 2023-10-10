import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../src/common_widgets/button/notification_button.dart';
import '../../src/providers/controllers.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
        toolbarHeight: kToolbarHeight,
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
                  color: kSecondaryColor,
                  largeIcon: "asset://assets/icons/app_icon.png",
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
