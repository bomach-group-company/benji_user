import 'package:benji/frontend/main/home.dart';
import 'package:benji/frontend/store/search.dart';
import 'package:benji/src/frontend/widget/cart.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../providers/constants.dart';

class MyMobileAppBar extends StatelessWidget {
  final bool hideSearch;
  const MyMobileAppBar({super.key, this.hideSearch = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
        color: Color(0xfffafafc),
        // border: Border(
        //   bottom: BorderSide(color: kAccentColor, width: 1),
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyClickable(
            navigate: const HomePage(),
            child: Image.asset(
              'assets/frontend/assets/brand/benji-logo-resized-nobg.png',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              // ignore: prefer_const_constructors
              CartWidget(),
              kWidthSizedBox,
              hideSearch
                  ? const SizedBox()
                  : MyClickable(
                      navigate: const SearchPage(),
                      child: Icon(
                        Icons.search,
                        color: kAccentColor,
                        size: 30,
                      ),
                    ),
              kWidthSizedBox,
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.menu,
                  color: kAccentColor,
                  size: 35,
                ),
                onTap: () {
                  // Open the drawer
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
