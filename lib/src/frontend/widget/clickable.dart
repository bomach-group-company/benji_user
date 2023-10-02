import 'package:flutter/material.dart';

class MyClickable extends StatelessWidget {
  final Widget child;
  final Widget? navigate;

  const MyClickable({super.key, required this.child, this.navigate});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () {
          if (navigate != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return navigate!;
                },
              ),
            );
          }
        },
        child: child,
      ),
    );
  }
}
