import 'package:flutter/material.dart';

import '../utils/constant.dart';

class MyOutlinedButton extends StatefulWidget {
  final Widget? navigate;
  const MyOutlinedButton({
    super.key,
    this.navigate,
  });

  @override
  State<MyOutlinedButton> createState() => _MyOutlinedButtonState();
}

class _MyOutlinedButtonState extends State<MyOutlinedButton> {
  bool btnHover = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onHover: (value) {
        setState(() {
          btnHover = value;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        side: const BorderSide(color: kGreenColor),
        foregroundColor: btnHover ? Colors.white : kGreenColor,
        backgroundColor: btnHover ? kGreenColor : Colors.transparent,
      ),
      onPressed: () {
        if (widget.navigate != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return widget.navigate!;
              },
            ),
          );
        }
      },
      child: const Text(
        'View All',
        style: TextStyle(),
      ),
    );
  }
}
