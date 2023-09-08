import 'package:benji_user/app/product/product_detail_screen.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/product/home_products_card.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/product/product.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';

class HomePageProducts extends StatefulWidget {
  const HomePageProducts({super.key});

  @override
  State<HomePageProducts> createState() => _HomePageProductsState();
}

class _HomePageProductsState extends State<HomePageProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map? _data;

  _getData() async {
    await checkAuth(context);
    List<Product> product = await getProducts();
    setState(() {
      _data = {
        'product': product,
      };
    });
  }
  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
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
          title: "Products",
          toolbarHeight: kToolbarHeight,
          backgroundColor: kPrimaryColor,
          actions: [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? SpinKitChasingDots(color: kAccentColor)
              : Scrollbar(
                  controller: _scrollController,
                  radius: Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: _data!['product'].length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(kDefaultPadding),
                    separatorBuilder: (context, index) => kHalfSizedBox,
                    itemBuilder: (BuildContext context, int index) =>
                        HomeProductsCard(
                      OnTap: () {
                        Get.to(
                          () => ProductDetailScreen(
                              product: _data!['product'][index]),
                          routeName: 'ProductDetailScreen',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                      product: _data!['product'][index],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}