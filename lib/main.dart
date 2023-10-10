import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:benji/app/splash_screens/startup_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/providers/controllers.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (!kIsWeb) {
    await Firebase.initializeApp();
    // await NotificationController.initializeNotification();
    FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  }

  // await dotenv.load();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Benji",
      color: kPrimaryColor,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //This is the home route
      home: WillPopScope(
        onWillPop: () => _showExitConfirmationDialog(context),
        child: const StartupSplashscreen(),
      ),
      // initialRoute: AppRoutes.startupSplashscreen,
      // getPages: AppRoutes.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(LatLngDetailController());
      }),
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) {
  debugPrint("Message from push notification is $message.data");
  return AwesomeNotifications().createNotificationFromJsonData(message.data);
}

_showExitConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Don't exit
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Exit
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
