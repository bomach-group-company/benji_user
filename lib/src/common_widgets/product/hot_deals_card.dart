import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/constants.dart';

class HotDealsCard extends StatelessWidget {
  const HotDealsCard({
    super.key,
  });

//===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 349.82,
        height: 325.29,
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.19),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19616161),
              blurRadius: 24,
              offset: Offset(0, 0),
              spreadRadius: 7,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 186.64,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/food/okra-soup.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            kSizedBox,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 57.06,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 313,
                      child: Text(
                        'Okra Soup and swallow',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    kHalfSizedBox,
                    SizedBox(
                      width: 313,
                      child: Text(
                        'Ntachi Osa Food',
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.43,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kSizedBox,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 313,
                child: Text(
                  '₦${formattedText(40000)}',
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 20,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
