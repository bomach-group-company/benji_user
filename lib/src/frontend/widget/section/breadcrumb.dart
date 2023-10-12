import 'package:benji/frontend/main/home.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';
import '../../utils/constant.dart';

class MyBreadcrumb extends StatefulWidget {
  final String text;
  final bool hasBeadcrumb;
  final String? back;
  final Widget? backNav;
  final String? current;
  const MyBreadcrumb({
    super.key,
    required this.text,
    this.hasBeadcrumb = false,
    this.current,
    this.back,
    this.backNav = const HomePage(),
  });

  @override
  State<MyBreadcrumb> createState() => _MyBreadcrumbState();
}

class _MyBreadcrumbState extends State<MyBreadcrumb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/frontend/assets/paragraph_bg/breadcrumb_bg_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: breakPoint(MediaQuery.of(context).size.width, 25, 0, 0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
              ),
              widget.hasBeadcrumb
                  ? Column(
                      children: [
                        kSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyClickable(
                              navigate: widget.backNav,
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
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
