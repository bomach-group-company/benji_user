import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../app/home/home.dart';
import '../button/my_elevatedbutton.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCard extends StatelessWidget {
  final String emptyCardMessage;
  final String buttonTitle;
  final dynamic onPressed;
  final bool showButton;
  const EmptyCard({
    super.key,
    this.emptyCardMessage = "Oops! There is nothing here",
    this.buttonTitle = "",
    this.onPressed,
    this.showButton = false,
  });


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(kDefaultPadding),
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/animations/empty/frame_1.json",
            ),
            kSizedBox,
            Text(
              emptyCardMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextGreyColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            kSizedBox,
            showButton == false
                ? const SizedBox()
                : MyElevatedButton(
              title: buttonTitle,
              onPressed: onPressed ?? (){ Get.offAll(
                    () => const Home(),
                routeName: 'Home',
                duration: const Duration(milliseconds: 300),
                fullscreenDialog: true,
                curve: Curves.easeIn,
                popGesture: false,
                predicate: (routes) => false,
                transition: Transition.rightToLeft,
              );
              },
            ),
          ],
        ),
      ],
    );
  }
}
