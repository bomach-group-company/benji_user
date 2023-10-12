import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';
import '../../utils/constant.dart';

class MyBorderCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const MyBorderCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  State<MyBorderCard> createState() => _MyBorderCardState();
}

class _MyBorderCardState extends State<MyBorderCard> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Container(
      width: deviceType(media.width) <= 2
          ? responsiveNumberSize(media.width, [
              media.width * 0.70,
              media.width * 0.75,
              media.width * 0.80,
              media.width * 0.85,
              media.width * 0.90,
            ])
          : responsiveNumberSize(media.width, [
              media.width * 0.30,
              media.width * 0.30,
              media.width * 0.25,
              media.width * 0.25,
              media.width * 0.25,
            ]),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: kAccentColor,
            size: 50,
          ),
          kHalfWidthSizedBox,
          SizedBox(
            width: breakPoint(media.width, media.width - 200,
                media.width * 0.45, media.width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subtitle,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
