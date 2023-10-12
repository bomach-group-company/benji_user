import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../src/providers/constants.dart';
import 'faqs.dart';
import 'file_a_complaint.dart';
import 'live_chat.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
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

  void _toFAQsPage() => Get.to(
        () => const FAQs(),
        routeName: 'FAQs',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toFileAComplaint() => Get.to(
        () => const FileAComplaint(),
        routeName: 'FileAComplaint',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
  void _toLiveChatPage() => Get.to(
        () => const LiveChat(),
        routeName: 'LiveChat',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Help and Support",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Lottie.asset(
                  "assets/animations/help_and_support/frame_1.json",
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                "Choose an option, we are here to serve you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kSizedBox,
              InkWell(
                onTap: _toFAQsPage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: media.width,
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  child: ListTile(
                    enableFeedback: true,
                    leading: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/faq.png"),
                        ),
                      ),
                    ),
                    title: const Text(
                      "FAQs",
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                      color: kTextBlackColor,
                    ),
                  ),
                ),
              ),
              kSizedBox,
              InkWell(
                onTap: _toFileAComplaint,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: media.width,
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  child: ListTile(
                    enableFeedback: true,
                    leading: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/complain.png"),
                        ),
                      ),
                    ),
                    title: const Text(
                      "File a complaint",
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                      color: kTextBlackColor,
                    ),
                  ),
                ),
              ),
              kSizedBox,
              InkWell(
                onTap: _toLiveChatPage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: media.width,
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  child: ListTile(
                    enableFeedback: true,
                    leading: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/support.png"),
                        ),
                      ),
                    ),
                    title: const Text(
                      "Live chat",
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                      color: kTextBlackColor,
                    ),
                  ),
                ),
              ),
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
