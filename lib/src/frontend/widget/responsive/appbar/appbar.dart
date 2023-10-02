import 'package:benji_user/src/frontend/widget/responsive/appbar/laptop_appbar.dart';
import 'package:benji_user/src/frontend/widget/responsive/appbar/mobile_appbar.dart';
import 'package:benji_user/src/frontend/widget/responsive/appbar/tablet_appbar.dart';
import 'package:flutter/material.dart';

import '../layout.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideSearch;

  const MyAppbar({super.key, this.hideSearch = true});

  @override
  Size get preferredSize => const Size(double.infinity, 120);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MyLayout(
        mobile: MyMobileAppBar(hideSearch: hideSearch),
        tablet: MyTabletAppBar(hideSearch: hideSearch),
        laptop: const MyLaptopAppBar(),
      ),
    );
  }
}
