import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class AllVendorsNearYouCard extends StatelessWidget {
  final Function() onTap;
  final String cardImage,
      vendorName,
      typeOfBusiness,
      rating,
      noOfUsersRated,
      distance;
  const AllVendorsNearYouCard({
    super.key,
    required this.onTap,
    required this.vendorName,
    required this.typeOfBusiness,
    required this.rating,
    required this.noOfUsersRated,
    required this.cardImage,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/vendors/$cardImage",
                  ),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
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
                        overflow: TextOverflow.ellipsis,
                        color: kTextBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.36,
                      ),
                    ),
                  ),
                  kSizedBox,
                  SizedBox(
                    width: media.width - 200,
                    child: Text(
                      typeOfBusiness,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kTextBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  kSizedBox,
                  Container(
                    width: media.width - 180,
                    child: Wrap(
                      runSpacing: 3,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: kStarColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: kDefaultPadding / 10,
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  "$rating ($noOfUsersRated+)",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kHalfWidthSizedBox,
                        SizedBox(
                          width: 70,
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidClock,
                                color: kAccentColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: kDefaultPadding / 10,
                              ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  distance,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
