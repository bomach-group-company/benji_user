import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';

class MyTeamCard extends StatelessWidget {
  const MyTeamCard({super.key});

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
          const CircleAvatar(
            radius: 70,
            backgroundImage:
                AssetImage('assets/frontend/assets/team/team1.jpg'),
          ),
          kSizedBox,
          Text(
            'Lorem',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          kSizedBox,
          const Text(
            'Legal Adviser',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          kSizedBox,
          const Text(
            '"Lorem is dummy ip[sum text t . Lorem is dummy ip[sum text t . Lorem is dummy ip[sum text t . Lorem is dummy ip[sum text t . Lorem is dummy ip[sum text t . Lorem is dummy ip[sum text t ."',
            textAlign: TextAlign.center,
            style: TextStyle(
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
