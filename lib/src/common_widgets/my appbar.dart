// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../../theme/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final Color backgroundColor;
  final List<Widget> actions;
  final double toolbarHeight;
  @override
  Size get preferredSize => const Size.fromHeight(
        80,
      );
  const MyAppBar({
    super.key,
    required this.title,
    required this.elevation,
    required this.actions,
    required this.backgroundColor,
    required this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: false,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
      title: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: SizedBox(
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
                          color: const Color(
                            0xFFFEF8F8,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
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
            style: const TextStyle(
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
