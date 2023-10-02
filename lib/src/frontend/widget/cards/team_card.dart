import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:flutter/material.dart';

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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage:
                AssetImage('assets/frontend/assets/team/team1.jpg'),
          ),
          kSizedBox,
          Text(
            'Lorem',
            style: TextStyle(
              color: kGreenColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          kSizedBox,
          Text(
            'Legal Adviser',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          kSizedBox,
          Text(
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
