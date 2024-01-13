import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constant.dart';

class VendorsCard extends StatelessWidget {
  final Function() onTap;
  final VendorModel vendor;
  final bool removeDistance;
  const VendorsCard({
    super.key,
    required this.onTap,
    required this.vendor,
    this.removeDistance = false,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 5,
              // offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 128,
              decoration: BoxDecoration(
                color: kPageSkeletonColor,
                // image: DecorationImage(
                //   image: AssetImage(cardImage),
                //   fit: BoxFit.cover,
                // ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7.20),
                  topRight: Radius.circular(7.20),
                ),
              ),
              child: Center(child: MyImage(url: vendor.shopImage)),
            ),
            kHalfSizedBox,
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      vendor.shopName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  SizedBox(
                    child: Text(
                      vendor.shopType.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: kStarColor,
                          size: 15,
                        ),
                        const SizedBox(width: 4.0),
                        SizedBox(
                          child: Text(
                            '${(vendor.dummyFloat).toStringAsPrecision(2)} (${vendor.dummyInt})',
                            style: const TextStyle(
                              color: kTextBlackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        removeDistance == true
                            ? const SizedBox()
                            : FaIcon(
                                FontAwesomeIcons.solidClock,
                                color: kAccentColor,
                                size: 15,
                              ),
                        removeDistance == true
                            ? const SizedBox()
                            : const SizedBox(width: 4.0),
                        removeDistance == true
                            ? const SizedBox()
                            : SizedBox(
                                width: deviceType(media.width) > 2 ? 80 : 60,
                                child: const Text(
                                  "30 mins",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ),
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
