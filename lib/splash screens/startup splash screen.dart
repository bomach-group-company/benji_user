// ignore_for_file: camel_case_types, file_names

import 'package:alpha_logistics/theme/colors.dart';
import 'package:alpha_logistics/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../onboarding/onboarding screen.dart';

class StartupSplashscreen extends StatefulWidget {
  static String routeName = "Startup Splash Screen";
  const StartupSplashscreen({super.key});

  @override
  State<StartupSplashscreen> createState() => _StartupSplashscreenState();
}

class _StartupSplashscreenState extends State<StartupSplashscreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => OnboardingScreen(),
        ),
      );
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/splash screen/frame-1.png",
                  ),
                ),
              ),
            ),
            kSizedBox,
            SpinKitThreeInOut(
              color: kSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
