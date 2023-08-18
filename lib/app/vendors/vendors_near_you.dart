import 'package:flutter/material.dart';

import '../../src/common_widgets/home_popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/common_widgets/my_appbar.dart';
import '../../theme/colors.dart';

class VendorsNearYou extends StatefulWidget {
  const VendorsNearYou({super.key});

  @override
  State<VendorsNearYou> createState() => _VendorsNearYouState();
}

class _VendorsNearYouState extends State<VendorsNearYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Vendors Near You ",
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
                distance: '46 mins',
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
