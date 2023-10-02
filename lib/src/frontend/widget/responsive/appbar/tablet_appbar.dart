import 'package:benji_user/frontend/main/home.dart';
import 'package:benji_user/frontend/store/search.dart';
import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:benji_user/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

class MyTabletAppBar extends StatelessWidget {
  final bool hideSearch;

  const MyTabletAppBar({super.key, this.hideSearch = true});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: media.width * 0.1),
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
        //   bottom: BorderSide(color: kGreenColor, width: 1),
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
              hideSearch
                  ? const SizedBox()
                  : const MyClickable(
                      navigate: SearchPage(),
                      child: Icon(
                        Icons.search,
                        color: kGreenColor,
                        size: 30,
                      ),
                    ),
              kWidthSizedBox,
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: const Icon(
                  Icons.menu,
                  color: kGreenColor,
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
