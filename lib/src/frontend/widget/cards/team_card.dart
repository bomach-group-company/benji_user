import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';

class MyTeamCard extends StatelessWidget {
  const MyTeamCard(
      {super.key,
      required this.name,
      required this.position,
      required this.description,
      required this.image});
  final String name;
  final String position;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(image),
          ),
          kSizedBox,
          Text(
            name,
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          kSizedBox,
          Text(
            position,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          kSizedBox,
          Text(
            '"$description"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
