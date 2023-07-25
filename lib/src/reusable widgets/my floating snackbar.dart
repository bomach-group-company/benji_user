import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../../theme/colors.dart';

void mySnackBar(
  BuildContext context,
  String title,
  String message,
  Duration duration,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 10,
                  decoration: ShapeDecoration(
                    color: kAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          20.0,
                        ),
                        bottom: Radius.circular(
                          20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                kHalfWidthSizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kTextBlackColor,
                      ),
                    ),
                    kHalfSizedBox,
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        message.toUpperCase(),
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: kGreyColor1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      duration: duration,
      dismissDirection: DismissDirection.vertical,
      margin: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: MediaQuery.of(context).size.height - 120,
      ),
      showCloseIcon: true,
      closeIconColor: kAccentColor,
      behavior: SnackBarBehavior.floating,
      backgroundColor: kPrimaryColor,
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
          bottom: Radius.circular(20.0),
        ),
      ),
    ),
  );
}
