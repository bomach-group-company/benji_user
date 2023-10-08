import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class FooterColumnText extends StatelessWidget {
  final String head;
  final List items;
  const FooterColumnText({super.key, required this.head, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            style: TextStyle(
              color: kAccentColor,
              fontSize: 20,
            ),
          ),
          kSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: items.map((item) {
              return Column(
                children: [
                  MyClickable(
                    navigate: item[1],
                    child: Text(
                      item[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
