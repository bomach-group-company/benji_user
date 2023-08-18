import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class MyElevatedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const MyElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kAccentColor,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: kBlackColor.withOpacity(0.4),
        minimumSize: Size(MediaQuery.of(context).size.width, 60),
        maximumSize: Size(MediaQuery.of(context).size.width, 60),
      ),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontFamily: "Sen",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
