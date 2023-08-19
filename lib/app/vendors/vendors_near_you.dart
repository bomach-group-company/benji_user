import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/vendor/all_vendors_near_you_card.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class VendorsNearYou extends StatefulWidget {
  const VendorsNearYou({super.key});

  @override
  State<VendorsNearYou> createState() => _VendorsNearYouState();
}

class _VendorsNearYouState extends State<VendorsNearYou> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();

    _loadingScreen = true;
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }

//============================================== ALL VARIABLES =================================================\\
  late bool _loadingScreen;

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _loadingScreen = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _loadingScreen = false;
    });
  }
  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Vendors Near You",
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
          actions: [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _loadingScreen
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(color: kAccentColor),
                  ],
                )
              : Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    itemCount: 20,
                    separatorBuilder: (context, index) => kHalfSizedBox,
                    itemBuilder: (context, index) {
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
      ),
    );
  }
}
