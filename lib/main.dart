import 'dart:io';

import 'package:benji/app/splash_screens/startup_splash_screen.dart';
import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/controller/auth_controller.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/controller/category_controller.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/favourite_controller.dart';
import 'package:benji/src/repo/controller/form_controller.dart';
import 'package:benji/src/repo/controller/login_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/order_status_change.dart';
import 'package:benji/src/repo/controller/package_controller.dart';
import 'package:benji/src/repo/controller/payment_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/profile_controller.dart';
import 'package:benji/src/repo/controller/shopping_location_controller.dart';
import 'package:benji/src/repo/controller/signup_controller.dart';
import 'package:benji/src/repo/controller/sub_category_controller.dart';
import 'package:benji/src/repo/controller/url_launch_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/repo/controller/lat_lng_controllers.dart';
import 'src/repo/controller/notifications_controller.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  Get.put(UserController());
  Get.put(AuthController());
  Get.put(ProfileController());
  Get.put(LoginController());
  Get.put(VendorController());
  Get.put(OrderController());
  Get.put(CategoryController());
  Get.put(SubCategoryController());
  Get.put(LatLngDetailController());
  Get.put(ProductController());
  Get.put(UrlLaunchController());
  Get.put(FormController());
  Get.put(ApiProcessorController());
  Get.put(AddressController());
  Get.put(CartController());
  Get.put(FavouriteController());
  Get.put(MyPackageController());
  Get.put(PaymentController());
  Get.put(OrderStatusChangeController());
  Get.put(SignupController());
  Get.put(ShoppingLocationController());
  // Get.put(ReviewsController());

  if (!kIsWeb) {
    // await Firebase.initializeApp();
    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await NotificationController.initializeNotification();

    // await FcmMessagingController.instance.handleFCM();
  }

  // await dotenv.load();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return GetMaterialApp(
        title: "Benji",
        color: kPrimaryColor,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        //This is the home route
        home: const StartupSplashscreen(),
      );
    }
    if (Platform.isIOS) {
      return GetCupertinoApp(
        title: "Shop Point",
        color: kPrimaryColor,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.iOSLightTheme,
        //This is the home route
        home: const StartupSplashscreen(),
      );
    } else if (Platform.isAndroid) {
      return GetMaterialApp(
        title: "Benji",
        color: kPrimaryColor,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        //This is the home route
        home: const StartupSplashscreen(),
      );
    }

    return GetMaterialApp(
      title: "Benji",
      color: kPrimaryColor,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //This is the home route
      home: const StartupSplashscreen(),
    );
  }
}
