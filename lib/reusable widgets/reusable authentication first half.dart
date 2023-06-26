import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/constants.dart';

class ReusableAuthenticationFirstHalf extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const ReusableAuthenticationFirstHalf({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: kDefaultPadding * 1.2,
            bottom: kDefaultPadding,
          ),
          child: Container(
            width: 88,
            height: 87,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  43.50,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          color: kSecondaryColor,
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kSizedBox,
              Text(
                subtitle,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
