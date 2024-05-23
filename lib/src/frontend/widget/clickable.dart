import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyClickable extends StatelessWidget {
  final Widget child;
  final Widget? navigate;
  final bool getOff;

  const MyClickable(
      {super.key, required this.child, this.navigate, this.getOff = true});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () {
          if (navigate != null) {
            if (getOff) {
              Get.off(
                () => navigate!,
                preventDuplicates: false,
                routeName: navigate.runtimeType.toString(),
                duration: const Duration(milliseconds: 300),
                fullscreenDialog: true,
                curve: Curves.easeIn,
                popGesture: true,
                transition: Transition.fadeIn,
              );
              return;
            }
            Get.to(
              () => navigate!,
              preventDuplicates: false,
              routeName: navigate.runtimeType.toString(),
              duration: const Duration(milliseconds: 300),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              popGesture: true,
              transition: Transition.fadeIn,
            );
          }
        },
        child: child,
      ),
    );
  }
}
