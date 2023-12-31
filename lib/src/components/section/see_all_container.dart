// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class SeeAllContainer extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool showSeeAll;
  const SeeAllContainer({
    super.key,
    required this.onPressed,
    required this.title,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kTextBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.40,
            ),
          ),
          InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            enableFeedback: true,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19616161),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
                color: const Color(0xFFFEF8F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    showSeeAll ? 'See all' : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.28,
                    ),
                  ),
                  const SizedBox(width: 8),
                  showSeeAll
                      ? FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 14,
                          color: kAccentColor,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
