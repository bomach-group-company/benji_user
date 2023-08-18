import 'package:benji_user/app/home/home.dart';
import 'package:benji_user/src/splash%20screens/startup%20splash%20screen.dart';
import 'package:benji_user/theme/app%20theme.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/favorite/favorite.dart';
import 'app/orders/track order.dart';

// import 'app/home/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    bool _vendorStatus = true;

    //Online Vendors
    final String _onlineVendorsName = "Ntachi Osa";
    final String _onlineVendorsImage = "ntachi-osa";
    final double _onlineVendorsRating = 4.6;

    final String _vendorActive = "Online";
    final String _vendorInactive = "Offline";
    final Color _vendorActiveColor = kSuccessColor;
    final Color _vendorInactiveColor = kAccentColor;

    //Offline Vendors
    final String _offlineVendorsName = "Best Choice Restaurant";
    final String _offlineVendorsImage = "best-choice-restaurant";
    final double _offlineVendorsRating = 4.0;

    return GetMaterialApp(
      title: "Benji",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: StartupSplashscreen(),
      home: Home(),
      // home: TrackOrder(),
      // home: Favorite(
      //   vendorCoverImage:
      //       _vendorStatus ? _onlineVendorsImage : _offlineVendorsImage,
      //   vendorName: _vendorStatus ? _onlineVendorsName : _offlineVendorsName,
      //   vendorRating:
      //       _vendorStatus ? _onlineVendorsRating : _offlineVendorsRating,
      //   vendorActiveStatus: _vendorStatus ? _vendorActive : _vendorInactive,
      //   vendorActiveStatusColor:
      //       _vendorStatus ? _vendorActiveColor : _vendorInactiveColor,
      // ),
    );
  }
}
