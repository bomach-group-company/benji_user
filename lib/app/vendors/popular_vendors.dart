import 'package:flutter/material.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/home_popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class PopularVendors extends StatefulWidget {
  const PopularVendors({super.key});

  @override
  State<PopularVendors> createState() => _PopularVendorsState();
}

class _PopularVendorsState extends State<PopularVendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Popular Vendors ",
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
              return HomePopularVendorsCard(
                onTap: () {},
                cardImage: 'best-choice-restaurant.png',
                vendorName: "Best Choice restaurant",
                food: "Food",
                category: "Fast Food",
                rating: "3.6",
                noOfUsersRated: "500",
              );
            },
          ),
        ),
      ),
    );
  }
}
