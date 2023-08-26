import 'dart:async';

import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../theme/colors.dart';
import '../auth/signup.dart';
import '../home/home.dart';

class StartupSplashscreen extends StatefulWidget {
  static String routeName = "Startup Splash Screen";
  const StartupSplashscreen({super.key});

  @override
  State<StartupSplashscreen> createState() => _StartupSplashscreenState();
}

class _StartupSplashscreenState extends State<StartupSplashscreen> {
  @override
  void initState() {
    super.initState();
    rememberUser().whenComplete(
      () async {
        Timer(
          Duration(seconds: 3),
          () {
            Get.offAll(
              () => obtainedUserDetails == null || obtainedUserDetails == ""
                  ? const SignUp(
                      logout: true,
                    )
                  : Home(),
              duration: const Duration(seconds: 2),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              routeName:
                  obtainedUserDetails == null || obtainedUserDetails == ""
                      ? "SignUp"
                      : "Home",
              predicate: (route) => false,
              popGesture: true,
              transition: Transition.fadeIn,
            );
          },
        );
      },
    );
  }

  User? obtainedUserDetails;

  Future rememberUser() async {
    final User? user = (await getUser()) as User?;

    setState(() {
      obtainedUserDetails = user;
    });
    print(obtainedUserDetails);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: mediaHeight,
            width: mediaWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: mediaHeight / 4,
                  width: mediaWidth / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/splash_screen/frame_1.png"),
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
        ],
      ),
    );
  }
}
