import 'package:benji/src/components/image/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCicleCard extends StatefulWidget {
  final String text;
  final String image;

  const MyCicleCard({super.key, required this.image, required this.text});

  @override
  State<MyCicleCard> createState() => _MyCicleCardState();
}

class _MyCicleCardState extends State<MyCicleCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.image);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipOval(
              child: MyImage(
                url: widget.image,
                width: double.infinity,
                height: null,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.text,
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
