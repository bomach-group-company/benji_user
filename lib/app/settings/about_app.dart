import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';
import '../home/home.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

//============================================== ALL VARIABLES =================================================\\

//============================================== BOOL VALUES =================================================\\

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

//============================================== NAVIGATION =================================================\\
  void _toHomePage() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 1000),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        predicate: (route) => false,
        popGesture: true,
        transition: Transition.cupertinoDialog,
      );
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "About the app",
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _toHomePage,
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: kAccentColor,
              size: deviceType(media.width) > 2 ? 30 : 24,
            ),
          ),
        ],
        backgroundColor: kPrimaryColor,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Image.asset(
                    "assets/images/logo/benji_full_logo.png",
                    fit: BoxFit.contain,
                    height: 60,
                  ),
                ),
              ),
              kSizedBox,
              Container(
                width: media.width,
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEF8F8),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0.50,
                      color: Color(0xFFFDEDED),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App name:",
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "Benji",
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App version:",
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "v0.0.1",
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.copyright,
                          size: 14,
                          color: kTextBlackColor,
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          "2023 Benji Express",
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: MyElevatedButton(
                        title: "Licenses",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
