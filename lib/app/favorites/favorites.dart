// ignore_for_file: unused_local_variable
import 'package:benji/app/business/business_detail_screen.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/product/product_card.dart';
import 'package:benji/src/repo/controller/favourite_controller.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/components/business/business_card.dart';
import '../../src/components/others/cart_card.dart';
import '../../src/components/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';
import '../product/product_detail_screen.dart';
import 'favorite_products.dart';
import 'favorite_vendors.dart';

class Favorites extends StatefulWidget {
  final String vendorCoverImage;
  final String vendorName;
  final double vendorRating;
  final String vendorActiveStatus;
  final Color vendorActiveStatusColor;

  const Favorites({
    super.key,
    required this.vendorCoverImage,
    required this.vendorName,
    required this.vendorRating,
    required this.vendorActiveStatus,
    required this.vendorActiveStatusColor,
  });

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites>
    with SingleTickerProviderStateMixin {
  //=================================== ALL VARIABLES ====================================\\
  //======================================================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    _tabBarController = TabController(length: 2, vsync: this);
  }

  Future<void> _handleRefresh() async {}

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

//==========================================================================================\\

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

//===================== Tabs ==========================\\
  int _selectedtabbar = 0;

  void _clickOnTabBarOption(value) async {
    setState(() {
      _selectedtabbar = value;
    });
  }

  //===================== Navigation ==========================\\

  void _toProductDetailsScreen(product) async {
    await Get.to(
      () => ProductDetailScreen(product: product),
      routeName: 'ProductDetailScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void _BusinessDetailScreenPage(vendor) async {
    await Get.to(
      () => BusinessDetailScreen(vendor: vendor),
      routeName: 'BusinessDetailScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

//====================================================================================\\

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    var media = MediaQuery.of(context).size;

//====================================================================================\\

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Favorites",
          elevation: 0.0,
          actions: const [CartCard(), kHalfWidthSizedBox],
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              kSizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Container(
                  width: media.width,
                  decoration: BoxDecoration(
                    color: kDefaultCategoryBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: kGreyColor1,
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
                          onTap: (value) => _clickOnTabBarOption(value),
                          splashBorderRadius: BorderRadius.circular(50),
                          enableFeedback: true,
                          mouseCursor: SystemMouseCursors.click,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: kTransparentColor,
                          automaticIndicatorColorAdjustment: true,
                          labelColor: kPrimaryColor,
                          unselectedLabelColor: kTextGreyColor,
                          indicator: BoxDecoration(
                            color: kAccentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          tabs: const [
                            Tab(text: "Products"),
                            Tab(text: "Vendors"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBox,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
                width: media.width,
                child: _selectedtabbar == 0
                    ? GetBuilder<FavouriteController>(
                        initState: (state) =>
                            FavouriteController.instance.getProduct(),
                        builder: (controller) {
                          if (controller.isLoad.value &&
                              controller.favouriteProducts.isEmpty) {
                            Center(
                              child: CircularProgressIndicator(
                                color: kAccentColor,
                              ),
                            );
                          }
                          return Scrollbar(
                            controller: _scrollController,
                            radius: const Radius.circular(10),
                            child: FavoriteProductsTab(
                              list: controller.favouriteProducts.isEmpty
                                  ? const EmptyCard(
                                      showButton: true,
                                      buttonTitle: "Add a product",
                                      emptyCardMessage:
                                          "You have no favorite products",
                                    )
                                  : LayoutGrid(
                                      rowGap: kDefaultPadding / 2,
                                      columnGap: kDefaultPadding / 2,
                                      columnSizes: breakPointDynamic(
                                          media.width,
                                          [1.fr],
                                          [1.fr, 1.fr],
                                          [1.fr, 1.fr, 1.fr],
                                          [1.fr, 1.fr, 1.fr, 1.fr]),
                                      rowSizes:
                                          controller.favouriteProducts.isEmpty
                                              ? [auto]
                                              : List.generate(
                                                  controller
                                                      .favouriteProducts.length,
                                                  (index) => auto),
                                      children: (controller.favouriteProducts)
                                          .map(
                                            (item) => ProductCard(
                                              onTap: () =>
                                                  _toProductDetailsScreen(item),
                                              product: item,
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ),
                          );
                        },
                      )
                    : GetBuilder<FavouriteController>(
                        initState: (state) =>
                            FavouriteController.instance.getVendor(),
                        builder: (controller) {
                          if (controller.isLoad.value &&
                              controller.favouriteVendors.isEmpty) {
                            Center(
                              child: CircularProgressIndicator(
                                color: kAccentColor,
                              ),
                            );
                          }
                          return FavoriteVendorsTab(
                            list: Scrollbar(
                              controller: _scrollController,
                              radius: const Radius.circular(10),
                              child: controller.favouriteVendors.isEmpty
                                  ? const EmptyCard(
                                      showButton: true,
                                      buttonTitle: "Add a vendor",
                                      emptyCardMessage:
                                          "You have no favorite vendors",
                                    )
                                  : LayoutGrid(
                                      rowGap: kDefaultPadding / 2,
                                      columnGap: kDefaultPadding / 2,
                                      columnSizes: breakPointDynamic(
                                          media.width,
                                          [1.fr],
                                          [1.fr, 1.fr],
                                          [1.fr, 1.fr, 1.fr],
                                          [1.fr, 1.fr, 1.fr, 1.fr]),
                                      rowSizes:
                                          controller.favouriteVendors.isEmpty
                                              ? [auto]
                                              : List.generate(
                                                  controller
                                                      .favouriteVendors.length,
                                                  (index) => auto),
                                      children: (controller.favouriteVendors)
                                          .map(
                                            (item) => BusinessCard(
                                              vendor: item,
                                              removeDistance: true,
                                              onTap: () {
                                                _BusinessDetailScreenPage(item);
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ),
                          );
                        }),
              ),
              kHalfSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
