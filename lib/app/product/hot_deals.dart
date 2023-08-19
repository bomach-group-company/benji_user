import 'package:flutter/material.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/home_hot_deals.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class HotDeals extends StatefulWidget {
  const HotDeals({super.key});

  @override
  State<HotDeals> createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Hot Deals",
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return HomeHotDeals();
            },
          ),
        ),
      ),
    );
  }
}
