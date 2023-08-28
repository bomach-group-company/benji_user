import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/vendor/all_vendors_near_you_card.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../src/repo/utils/helpers.dart';
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
    _getData();
  }

  Map? _data;

  _getData() async {
    await checkAuth(context);
    List<VendorModel> vendor = await getVendors();
    setState(() {
      _data = {
        'vendor': vendor,
      };
    });
  }

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
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
          child: _data == null
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
                    itemCount: _data!['vendor'].length,
                    separatorBuilder: (context, index) => kHalfSizedBox,
                    itemBuilder: (context, index) => AllVendorsNearYouCard(
                      onTap: () {},
                      cardImage: 'ntachi-osa.png',
                      vendorName: _data!['vendor'][index].shopName,
                      typeOfBusiness: "Restaurant",
                      distance: "45 mins",
                      rating: "3.6",
                      noOfUsersRated: "500",
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
