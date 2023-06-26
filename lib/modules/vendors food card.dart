import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/constants.dart';

class VendorFoodCard extends StatelessWidget {
  final Function() onTap;
  const VendorFoodCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding / 1.5,
          right: kDefaultPadding,
        ),
        child: Container(
          width: 350,
          height: 88,
          decoration: ShapeDecoration(
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 88,
                height: 92,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        12,
                      ),
                      bottomLeft: Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/food/pasta.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              kHalfWidthSizedBox,
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smokey Jollof Pasta',
                      style: TextStyle(
                        color: Color(
                          0xFF333333,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 205,
                      child: Text(
                        'Short description about the food here',
                        style: TextStyle(
                          color: Color(0xFF676565),
                          fontSize: 13,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 205,
                      child: Text(
                        'N 850',
                        style: TextStyle(
                          color: Color(
                            0xFF333333,
                          ),
                          fontSize: 14,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_rounded,
                      color: kAccentColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
