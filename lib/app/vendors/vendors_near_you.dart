import 'package:flutter/material.dart';

import '../../src/common_widgets/vendor/all_vendors_near_you_card.dart';
import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/providers/constants.dart';
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
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return AllVendorsNearYouCard(
                onTap: () {},
                cardImage: 'best-choice-restaurant.png',
                vendorName: "Best Choice restaurant",
                distance: "45 mins",
                bannerColor: kAccentColor,
                bannerText: "Free Delivery",
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
