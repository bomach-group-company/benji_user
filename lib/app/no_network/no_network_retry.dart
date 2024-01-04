import 'dart:math';

import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../src/providers/constants.dart';

class NoNetworkRetry extends StatefulWidget {
  const NoNetworkRetry({super.key});

  @override
  State<NoNetworkRetry> createState() => _NoNetworkRetryState();
}

class _NoNetworkRetryState extends State<NoNetworkRetry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: MyElevatedButton(
          title: "Try again",
          onPressed: (){Get.close(1);},
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          children: [
            Center(
              child: Lottie.asset(
                "assets/animations/no_internet/frame_1.json",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
