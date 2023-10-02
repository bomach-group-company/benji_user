import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:flutter/material.dart';

class TitleBody extends StatelessWidget {
  final String title;
  final String body;
  const TitleBody({super.key, this.title = '', this.body = ''});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: breakPoint(media.width, 25, 50, 50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff2d2942),
              fontWeight: FontWeight.bold,
            ),
          ),
          kSizedBox,
          kHalfSizedBox,
          Text(
            body,
            style: const TextStyle(
                fontSize: 18, color: Color(0xff2d2942), height: 1.5),
          ),
        ],
      ),
    );
  }
}
