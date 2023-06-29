import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final Color backgroundColor;
  final List<Widget> actions;
  Size get preferredSize => Size.fromHeight(
        80,
      );
  const MyAppBar({
    super.key,
    required this.title,
    required this.elevation,
    required this.actions,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Container(
                width: 48,
                height: 48,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(
                            0xFFFEF8F8,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: Color(
                                0xFFFDEDED,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          kWidthSizedBox,
          Text(
            title,
            style: TextStyle(
              color: Color(
                0xFF151515,
              ),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.40,
            ),
          ),
        ],
      ),
    );
  }
}
