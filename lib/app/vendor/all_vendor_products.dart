import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/common_widgets/button/category%20button.dart';
import 'package:benji_user/src/common_widgets/vendor/product_container.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/models/category/sub_category.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/product/product.dart';
import '../../theme/colors.dart';
import '../product/product_detail_screen.dart';

class AllVendorProducts extends StatefulWidget {
  final VendorModel vendor;

  const AllVendorProducts({
    super.key,
    required this.vendor,
  });

  @override
  State<AllVendorProducts> createState() => _AllVendorProductsState();
}

class _AllVendorProductsState extends State<AllVendorProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }
//==========================================================================================\\

  //=================================== LOGIC ====================================\\
  Map? _data;

  String activeCategory = '';

  _getData() async {
    await checkAuth(context);

    List<SubCategory> categories = await getSubCategories();
    List<Product> product = [];
    try {
      activeCategory = categories[0].id;
      product = await getProductsByVendorSubCategory(
          widget.vendor.id!, activeCategory);
    } catch (e) {}

    setState(() {
      _data = {'product': product, 'categories': categories};
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }

  //=================================== CONTROLLERS ====================================\\
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

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

  //========================================================================\\

  //============================================= Navigation =======================================\\
  void _toProductDetailScreen(product) => Get.to(
        () => ProductDetailScreen(product: product),
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
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: _data == null
                ? SpinKitChasingDots(color: kAccentColor)
                : ListView(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          itemCount: _data!['categories'].length,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: CategoryButton(
                              onPressed: () {
                                setState(() {
                                  activeCategory =
                                      _data!['categories'][index].id;
                                });
                              },
                              title: _data!['categories'][index].name,
                              bgColor: activeCategory ==
                                      _data!['categories'][index].id
                                  ? kAccentColor
                                  : kDefaultCategoryBackgroundColor,
                              categoryFontColor: activeCategory ==
                                      _data!['categories'][index].id
                                  ? kPrimaryColor
                                  : kTextGreyColor,
                            ),
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      ListView.separated(
                        itemCount: _data!['product'].length,
                        separatorBuilder: (context, index) => kHalfSizedBox,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => ProductContainer(
                          product: _data!['product'][index],
                          onTap: () =>
                              _toProductDetailScreen(_data!['product'][index]),
                        ),
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
