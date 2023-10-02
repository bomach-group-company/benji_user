import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';
import '../../utils/constant.dart';

class SimpleCard extends StatelessWidget {
  final String title;
  final String sub;
  const SimpleCard({super.key, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Container(
      width: breakPointDynamic(
        media.width,
        media.width * 0.90,
        media.width * 0.432,
        media.width * 0.22,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
            color: Colors.grey,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.ac_unit,
                color: kAccentColor,
              ),
              kHalfWidthSizedBox,
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          kHalfSizedBox,
          SizedBox(
            width: media.width,
            child: Text(
              sub,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
