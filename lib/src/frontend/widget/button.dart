import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../theme/colors.dart';

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
        side: BorderSide(color: kAccentColor),
        foregroundColor: btnHover ? Colors.white : kAccentColor,
        backgroundColor: btnHover ? kAccentColor : kTransparentColor,
      ),
      onPressed: () {
        if (widget.navigate != null) {
          Get.off(
            () => widget.navigate!,
            routeName: widget.navigate.runtimeType.toString(),
            duration: const Duration(milliseconds: 300),
            fullscreenDialog: true,
            curve: Curves.easeIn,
            popGesture: true,
            transition: Transition.fadeIn,
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
