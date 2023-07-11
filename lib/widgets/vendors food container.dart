import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../theme/colors.dart';

class VendorFoodContainer extends StatelessWidget {
  final Function() onTap;
  const VendorFoodContainer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2.5,
        ),
        width: MediaQuery.of(context).size.width,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 90,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    child: Text(
                      'Short description about the food here',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(
                          0xFF676565,
                        ),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      '₦1200.00',
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
          ],
        ),
      ),
    );
  }
}
