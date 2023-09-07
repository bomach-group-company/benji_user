import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';

class MyPackages extends StatefulWidget {
  const MyPackages({super.key});

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages> {
//================================================= BOOL VALUES ===================================================\\
  bool _loadingTabBarContent = false;

//================================================= FUNCTIONS ===================================================\\

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  void _clickOnTabBarOption() async {
    setState(() {
      _loadingTabBarContent = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _loadingTabBarContent = false;
    });
  }

  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "My Packages",
          elevation: 0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
      ),
    );
  }
}
