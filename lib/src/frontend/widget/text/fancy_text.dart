import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFancyText extends StatelessWidget {
  final String text;
  const MyFancyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Text(
      text,
      style: GoogleFonts.oleoScript(
        color: kGreenColor,
        fontSize: media.width * 0.035 + 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
