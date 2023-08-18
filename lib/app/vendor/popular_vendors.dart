import 'package:flutter/material.dart';

import '../../src/common_widgets/home popular vendors card.dart';
import '../../src/providers/constants.dart';
import '../../src/common_widgets/my appbar.dart';
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
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return PopularVendorsCard(
                onTap: () {},
                cardImage: 'best-choice-restaurant.png',
                bannerColor: kAccentColor,
                bannerText: "Free Delivery",
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
