import 'package:flutter/material.dart';

class MyCicleCard extends StatelessWidget {
  final String text;
  final String image;

  const MyCicleCard({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: AspectRatio(
            // aspectRatio: 1,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
            // ),
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
