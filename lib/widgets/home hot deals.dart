import 'package:flutter/material.dart';

import '../providers/constants.dart';

class HomeHotDeals extends StatelessWidget {
  const HomeHotDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 349.82,
        height: 325.29,
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              14.19,
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(
                0x19616161,
              ),
              blurRadius: 23.46,
              offset: Offset(
                0,
                0,
              ),
              spreadRadius: 6.40,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 340,
              height: 186.64,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
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
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Container(
                width: 255,
                height: 57.06,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 313,
                      height: 23,
                      child: Text(
                        'Okra Soup and swallow',
                        style: TextStyle(
                          color: Color(
                            0xFF333333,
                          ),
                          fontSize: 20,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    SizedBox(
                      width: 195.17,
                      height: 17.06,
                      child: Text(
                        'Ntachi Osa Food',
                        style: TextStyle(
                          color: Color(
                            0xFF707070,
                          ),
                          fontSize: 16,
                          fontFamily: 'Sen',
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
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: SizedBox(
                width: 159,
                child: Text(
                  'N40,000',
                  style: TextStyle(
                    color: Color(
                      0xFF333333,
                    ),
                    fontSize: 20,
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
