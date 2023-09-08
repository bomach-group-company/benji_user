import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../theme/colors.dart';
import 'bank_transfer.dart';
import 'card_payment.dart';

class PaymentMethod extends StatefulWidget {
  final double totalPrice;
  const PaymentMethod({super.key, required this.totalPrice});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod>
    with SingleTickerProviderStateMixin {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();

    _tabBarController = TabController(length: 2, vsync: this);
    _loadingScreen = true;
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }
//==========================================================================================\\

  //=================================== ALL VARIABLES ====================================\\
  int selectedRating = 0;

  //=========================== CONTROLLER ====================================\\

  TextEditingController cardNumberEC = TextEditingController();
  TextEditingController expiryDateEC = TextEditingController();
  TextEditingController cvvEC = TextEditingController();
  TextEditingController cardHoldersFullNameEC = TextEditingController();
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

  //=========================== FOCUS NODES ====================================\\

  FocusNode cardNumberFN = FocusNode();
  FocusNode expiryDateFN = FocusNode();
  FocusNode cvvFN = FocusNode();
  FocusNode cardHoldersFullNameFN = FocusNode();
  FocusNode rateVendorFN = FocusNode();

//===================== BOOL VALUES =======================\\
  late bool _loadingScreen;

//===================== VENDORS LIST VIEW INDEX =======================\\
  List<int> foodListView = [0, 1, 3, 4, 5, 6];

//===================== FUNCTIONS =======================\\
  void validate() {
    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "Thank you for your feedback!",
      Duration(seconds: 1),
    );

    Get.back();
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

  void _clickOnTabBarOption() async {}

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBody: true,
        appBar: MyAppBar(
          title: "Payment Method",
          elevation: 0,
          backgroundColor: kPrimaryColor,
          toolbarHeight: 40,
          actions: [],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _loadingScreen
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding,
                        ),
                        child: Container(
                          width: mediaWidth,
                          decoration: BoxDecoration(
                            color: kDefaultCategoryBackgroundColor,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: kLightGreyColor,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TabBar(
                                  controller: _tabBarController,
                                  onTap: (value) => _clickOnTabBarOption(),
                                  enableFeedback: true,
                                  mouseCursor: SystemMouseCursors.click,
                                  automaticIndicatorColorAdjustment: true,
                                  overlayColor:
                                      MaterialStatePropertyAll(kAccentColor),
                                  labelColor: kPrimaryColor,
                                  unselectedLabelColor: kTextGreyColor,
                                  indicatorColor: kAccentColor,
                                  indicatorWeight: 2,
                                  splashBorderRadius: BorderRadius.circular(50),
                                  indicator: BoxDecoration(
                                    color: kAccentColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  tabs: const [
                                    Tab(text: "Bank Transfer"),
                                    Tab(text: "Card payment"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kSizedBox,
                      Container(
                        // height: mediaHeight,
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2,
                        ),
                        child: Column(
                          children: [
                            AutoScaleTabBarView(
                              controller: _tabBarController,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                BankTransfer(totalPrice: widget.totalPrice),
                                CardPayment(),
                              ],
                            )
                          ],
                        ),
                      ),
                      kSizedBox,
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
