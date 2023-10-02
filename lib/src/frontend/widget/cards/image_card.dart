import 'package:flutter/material.dart';

class MyImageCard extends StatefulWidget {
  final String image;
  const MyImageCard({super.key, required this.image});

  @override
  State<MyImageCard> createState() => _MyImageCardState();
}

class _MyImageCardState extends State<MyImageCard> {
  bool isZoom = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isZoom = true;
        });
      },
      onExit: (event) {
        setState(() {
          isZoom = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: isZoom ? -30 : null,
                bottom: isZoom ? -30 : null,
                left: isZoom ? -30 : null,
                right: isZoom ? -30 : null,
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(seconds: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
