import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:flutter/material.dart';

class MyContentText extends StatelessWidget {
  final String title;
  final String content;
  const MyContentText({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff2d2942),
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        kSizedBox,
        Text(
          content,
          style: const TextStyle(
              fontSize: 18, color: Color(0xff2d2942), height: 1.5),
        ),
        kSizedBox,
        kHalfSizedBox,
      ],
    );
  }
}
