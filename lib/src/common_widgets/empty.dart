import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/animations/empty/frame_1.json",
          height: 300,
        ),
        kSizedBox,
        Text(
          "Oops!, There is nothing here",
          style: TextStyle(
            color: kTextGreyColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
