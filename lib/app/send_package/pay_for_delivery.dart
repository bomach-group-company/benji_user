import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../home/home.dart';

class PayForDelivery extends StatefulWidget {
  const PayForDelivery({super.key});

  @override
  State<PayForDelivery> createState() => _PayForDeliveryState();
}

class _PayForDeliveryState extends State<PayForDelivery> {
  //=================================== INITIAL STATE ==========================================\\
  @override
  void initState() {
    super.initState();
  }

  //=================================== ALL VARIABLES ==========================================\\

  Map? _data;
  final double _subTotal = 0;
  final double _totalPrice = 0;
  double deliveryFee = 700;
  double serviceFee = 0;
  // double insuranceFee = 0;
  // double discountFee = 0;

  //===================== GlobalKeys =======================\\

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //===================== CONTROLLERS =======================\\

  final ScrollController _scrollController = ScrollController();

  //===================== BOOL VALUES =======================\\
  final bool _isLoading = false;

  //===================== FUNCTIONS =======================\\
  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    // await _getData();
  }

  void _toHomeScreen() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        predicate: (routes) => false,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(
          title: "Checkout",
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _toHomeScreen,
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 18,
                semanticLabel: "Home",
                color: kAccentColor,
              ),
            ),
          ],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitChasingDots(color: kAccentColor),
                      kSizedBox,
                      Text(
                        "Loading...",
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: kAccentColor,
                  displacement: kDefaultPadding,
                  semanticsLabel: "Pull to refresh",
                  onRefresh: _handleRefresh,
                  child: () {
                    return Scrollbar(
                      controller: _scrollController,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(kDefaultPadding),
                        children: [
                          Lottie.asset(
                            "assets/animations/delivery/frame_2.json",
                            alignment: Alignment.center,
                            height: 150,
                          ),
                          kSizedBox,
                          const Text(
                            'Package Summary',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kSizedBox,
                          Container(
                            width: media.width,
                            padding: const EdgeInsets.all(kDefaultPadding),
                            decoration: ShapeDecoration(
                              color: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 24,
                                  offset: Offset(0, 4),
                                  spreadRadius: 7,
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                          kSizedBox,
                          Container(
                            width: media.width,
                            padding: const EdgeInsets.all(kDefaultPadding),
                            decoration: ShapeDecoration(
                              color: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 24,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Text(
                                    'Payment Summary',
                                    style: TextStyle(
                                      color: kTextBlackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Divider(height: 20, color: kGreyColor1),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Subtotal',
                                          style: TextStyle(
                                            color: kTextBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '₦${formattedText(_subTotal)}',
                                          style: TextStyle(
                                            color: kTextGreyColor,
                                            fontSize: 16,
                                            fontFamily: 'Sen',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    kSizedBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Delivery Fee',
                                          style: TextStyle(
                                            color: kTextBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '₦${formattedText(deliveryFee)}',
                                          style: TextStyle(
                                            color: kTextGreyColor,
                                            fontSize: 16,
                                            fontFamily: 'Sen',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    kSizedBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Service Fee',
                                          style: TextStyle(
                                            color: kTextBlackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '₦${formattedText(serviceFee)}',
                                          style: TextStyle(
                                            color: kTextGreyColor,
                                            fontSize: 16,
                                            fontFamily: 'Sen',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                kHalfSizedBox,
                                const Divider(height: 4, color: kGreyColor1),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        color: kTextBlackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '₦${formattedText(_totalPrice)}',
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontSize: 16,
                                        fontFamily: 'Sen',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding * 2),
                          _isLoading
                              ? Center(
                                  child: SpinKitChasingDots(
                                    color: kAccentColor,
                                    duration: const Duration(seconds: 1),
                                  ),
                                )
                              : MyElevatedButton(
                                  title:
                                      "Place Order - ₦${formattedText(_totalPrice)}",
                                  onPressed: () {
                                    // _placeOrder();
                                  },
                                ),
                          kSizedBox,
                        ],
                      ),
                    );
                  }(),
                ),
        ),
      ),
    );
  }
}
