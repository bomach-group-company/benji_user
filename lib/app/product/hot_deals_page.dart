import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\
  late bool _loadingScreen;

  //==================================================== CONTROLLERS ======================================================\\
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
          title: "Hot Deals",
          toolbarHeight: 80,
          backgroundColor: kPrimaryColor,
          actions: [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _loadingScreen
              ? SpinKitChasingDots(color: kAccentColor)
              : Scrollbar(
                  controller: _scrollController,
                  radius: Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: 20,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(kDefaultPadding),
                    separatorBuilder: (context, index) => kHalfSizedBox,
                    itemBuilder: (BuildContext context, int index) =>
                        HotDealsCard(),
                  ),
                ),
        ),
      ),
    );
  }
}
