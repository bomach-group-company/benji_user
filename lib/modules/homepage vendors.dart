import 'package:flutter/material.dart';

import '../app/vendor/vendor.dart';
import '../theme/colors.dart';
import '../providers/constants.dart';

class HomePageVendorsCard extends StatelessWidget {
  const HomePageVendorsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Vendor(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
              left: kDefaultPadding / 2,
            ),
            decoration: ShapeDecoration(
              color: kPrimaryColor,
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
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 224,
                      height: 128,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/vendors/ntachi-osa.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            7.20,
                          ),
                          topRight: Radius.circular(
                            7.20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              kAccentColor, // Customize the banner background color
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              8,
                            ),
                            bottomLeft: Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: 92.72,
                          height: 18,
                          child: Text(
                            "20% Discount",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHalfSizedBox,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 26,
                        child: Text(
                          'Ntachi Osa',
                          style: TextStyle(
                            color: Color(
                              0xFF222222,
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        width: 200,
                        height: 17,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Burgers ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0x662F2E3C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Container(
                              width: 3.90,
                              height: 3.90,
                              decoration: ShapeDecoration(
                                color: Color(
                                  0x662F2E3C,
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Fast Food',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                  0x662F2E3C,
                                ),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        width: 200,
                        height: 17,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: kAccentColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              '3.6 (500+)',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.28,
                              ),
                            ),
                            SizedBox(
                              width: 28,
                            ),
                            Icon(
                              Icons.access_time_filled_rounded,
                              color: kAccentColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '30 mins',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.28,
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
        ),
      ),
    );
  }
}
