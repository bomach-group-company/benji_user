import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class MyOutlinedElevatedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const MyOutlinedElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: kAccentColor,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        shadowColor: kBlackColor.withOpacity(
          0.4,
        ),
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          60,
        ),
        maximumSize: Size(
          MediaQuery.of(context).size.width,
          60,
        ),
      ),
      child: SizedBox(
        child: Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kAccentColor,
            fontSize: 18,
            fontFamily: "Sen",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
