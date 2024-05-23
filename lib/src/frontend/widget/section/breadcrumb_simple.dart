import 'package:benji/frontend/main/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../providers/constants.dart';
import '../../utils/constant.dart';

class MyBreadcrumbSimple extends StatefulWidget {
  final String? back;
  final bool goBack;
  final String? current;
  final Widget? navigate;

  const MyBreadcrumbSimple({
    super.key,
    this.current,
    this.back,
    this.navigate = const HomePage(),
    this.goBack = true,
  });

  @override
  State<MyBreadcrumbSimple> createState() => _MyBreadcrumbSimpleState();
}

class _MyBreadcrumbSimpleState extends State<MyBreadcrumbSimple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: breakPoint(MediaQuery.of(context).size.width, 25, 0, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (widget.goBack) {
                print(widget.goBack);
                Get.back();
                return;
              }

              Get.off(
                () => widget.navigate!,
                preventDuplicates: false,
                routeName: widget.navigate.runtimeType.toString(),
                duration: const Duration(milliseconds: 300),
                fullscreenDialog: true,
                curve: Curves.easeIn,
                popGesture: true,
                transition: Transition.fadeIn,
              );
            },
            child: Text(
              widget.back ?? "home",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          kHalfWidthSizedBox,
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.grey,
            size: 12,
          ),
          kHalfWidthSizedBox,
          Text(
            widget.current ?? "Home",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
