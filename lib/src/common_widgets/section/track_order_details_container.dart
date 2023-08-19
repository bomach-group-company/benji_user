import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class TrackOrderDetailsContainer extends StatelessWidget {
  final IconData shipIconDetail;
  final Color shipIconDetailColor;
  final String shipDetailText;
  final Color shipDetailTextColor;
  const TrackOrderDetailsContainer({
    super.key,
    required this.shipIconDetail,
    required this.shipIconDetailColor,
    required this.shipDetailText,
    required this.shipDetailTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 104,
      decoration: ShapeDecoration(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: Color(0xFFF0F0F0),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          kDefaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      shipIconDetail,
                      color: shipIconDetailColor,
                      size: 10,
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      shipDetailText,
                      style: TextStyle(
                        color: shipDetailTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kHalfWidthSizedBox,
                    Container(
                      width: 4,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: Color(0xFFC4C4C4),
                        shape: OvalBorder(),
                      ),
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      '2 items',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'May 30',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kHalfWidthSizedBox,
                    Container(
                      width: 4,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: Color(0xFFC4C4C4),
                        shape: OvalBorder(),
                      ),
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      '14:30',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#1228730aebcf...421289',
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'N4,000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
