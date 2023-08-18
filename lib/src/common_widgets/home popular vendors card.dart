import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../../theme/colors.dart';

class PopularVendorsCard extends StatelessWidget {
  final Function() onTap;
  final String cardImage,
      vendorName,
      food,
      category,
      rating,
      noOfUsersRated,
      bannerText;
  final Color bannerColor;
  final String distance;
  const PopularVendorsCard({
    super.key,
    required this.onTap,
    required this.vendorName,
    required this.food,
    required this.category,
    required this.rating,
    required this.noOfUsersRated,
    required this.cardImage,
    required this.bannerColor,
    required this.bannerText,
    this.distance = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 355,
        height: 130,
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(
                0x0F000000,
              ),
              blurRadius: 24,
              offset: Offset(
                0,
                4,
              ),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/food/$cardImage",
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 30,
                    width: 110,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          bannerColor, // Customize the banner background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20.0,
                        ),
                        bottomRight: Radius.circular(
                          20.0,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 60,
                      height: 20,
                      child: Text(
                        bannerText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            kHalfWidthSizedBox,
            Container(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      vendorName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.36,
                      ),
                    ),
                  ),
                  kSizedBox,
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          food,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(
                              0x662F2E3C,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3.90,
                          height: 3.90,
                          decoration: ShapeDecoration(
                            color: Color(0x662F2E3C),
                            shape: OvalBorder(),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x662F2E3C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  Container(
                    padding: EdgeInsets.only(
                      top: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: kAccentColor,
                            ),
                            SizedBox(
                              width: kDefaultPadding / 10,
                            ),
                            Text(
                              "$rating ($noOfUsersRated+)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ],
                        ),
                        kHalfWidthSizedBox,
                        distance != ''
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: kAccentColor,
                                  ),
                                  SizedBox(
                                    width: kDefaultPadding / 10,
                                  ),
                                  Text(
                                    '30 mins',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.28,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
