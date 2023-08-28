import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/common_widgets/section/category_button_section.dart';
import 'package:benji_user/src/common_widgets/vendor/vendors_product_container.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../product/product_detail_screen.dart';

class AllVendorProducts extends StatefulWidget {
  const AllVendorProducts({super.key});

  @override
  State<AllVendorProducts> createState() => _AllVendorProductsState();
}

class _AllVendorProductsState extends State<AllVendorProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
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

  @override
  void dispose() {
    super.dispose();
  }
//==========================================================================================\\

  //=================================== ALL VARIABLES ====================================\\

  //=================================== CONTROLLERS ====================================\\
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

//===================== BOOL VALUES =======================\\
  late bool _loadingScreen;

//===================== CATEGORY BUTTONS =======================\\
  final List _categoryButtonText = [
    "Pasta",
    "Burgers",
    "Rice Dishes",
    "Chicken",
    "Snacks"
  ];

  final List<Color> _categoryButtonBgColor = [
    kAccentColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor
  ];
  final List<Color> _categoryButtonFontColor = [
    kPrimaryColor,
    kTextGreyColor,
    kTextGreyColor,
    kTextGreyColor,
    kTextGreyColor
  ];

//=================================================== FUNCTIONS =====================================================\\
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

  //============================================= Navigation =======================================\\
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

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          title: "All Products",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          child: Scrollbar(
            controller: _scrollController,
            child: _loadingScreen
                ? SpinKitChasingDots(color: kAccentColor)
                : ListView(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CategoryButtonSection(
                        category: _categoryButtonText,
                        categorybgColor: _categoryButtonBgColor,
                        categoryFontColor: _categoryButtonFontColor,
                      ),
                      kHalfSizedBox,
                      ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (context, index) => kHalfSizedBox,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            VendorsProductContainer(
                                onTap: _toProductDetailScreen),
                      ),
                      kSizedBox
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
