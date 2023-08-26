import 'package:benji_user/app/checkout/checkout_screen.dart';
import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji_user/src/common_widgets/vendor/vendors_product_container.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../src/providers/constants.dart';
import '../product/product_detail_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//==================================================== INITIAL STATE AND DISPOSE ==========================================================\\
  @override
  void initState() {
    super.initState();

    _loadingScreen = true;

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }

  //============================================================ ALL VARIABLES ===================================================================\\
  int _itemCount = 12;

//====================================================== BOOL VALUES ========================================================\\
  late bool _loadingScreen;

  //==================================================== CONTROLLERS ======================================================\\
  ScrollController _scrollController = ScrollController();

//==================================================== FUNCTIONS ==========================================================\\
  //===================== Number format ==========================\\
  String formattedText(int value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

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

  //================================== Navigation =======================================\\

  void _toProductDetailScreen() => Get.to(
        () => ProductDetailScreen(),
        routeName: 'ProductDetailScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toCheckoutScreen() => Get.to(
        () => const CheckoutScreen(),
        routeName: 'CheckoutScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Cart",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: MyElevatedButton(
            onPressed: _toCheckoutScreen,
            title: "Checkout (₦ ${formattedText(12000)})",
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _loadingScreen
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kSizedBox,
                    SpinKitChasingDots(color: kAccentColor),
                  ],
                )
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        "Cart Summary".toUpperCase(),
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kSizedBox,
                      Container(
                        width: mediaWidth,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 24,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "₦ ${formattedText(12000)}",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontFamily: 'sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Text(
                        "Cart (${formattedText(_itemCount)})".toUpperCase(),
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kSizedBox,
                      ListView.separated(
                        separatorBuilder: (context, index) => kHalfSizedBox,
                        itemCount: _itemCount,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return VendorsProductContainer(
                            onTap: _toProductDetailScreen,
                          );
                        },
                      ),
                      SizedBox(height: kDefaultPadding * 4),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
