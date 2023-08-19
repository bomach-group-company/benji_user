import 'package:flutter/material.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/product/hot_deals_card.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class HotDealsPage extends StatefulWidget {
  const HotDealsPage({super.key});

  @override
  State<HotDealsPage> createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<HotDealsPage> {
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
              return HotDealsCard();
            },
          ),
        ),
      ),
    );
  }
}
