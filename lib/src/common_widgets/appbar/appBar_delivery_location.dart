import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';

class AppBarDeliveryLocation extends StatelessWidget {
  final String deliveryLocation;
  final Function() toDeliverToPage;
  const AppBarDeliveryLocation({
    super.key,
    required this.deliveryLocation,
    required this.toDeliverToPage,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: toDeliverToPage,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Address',
                  style: TextStyle(
                    color: kAccentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: max(100, media.width - 250),
                  child: Text(
                    deliveryLocation,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14,
              color: kAccentColor,
            ),
          ],
        ),
      ),
    );
  }
}
