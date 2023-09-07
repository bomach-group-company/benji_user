// ignore_for_file: unused_local_variable
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:benji_user/app/vendor/vendor_details.dart';
import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/common_widgets/cart.dart';
import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:benji_user/src/common_widgets/product/home_products_card.dart';
import 'package:benji_user/src/common_widgets/snackbar/my_floating_snackbar.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/src/repo/utils/favorite.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/vendor/popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../src/repo/models/product/product.dart';
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
    _tabBarController = TabController(length: 2, vsync: this);

    if (_tabBarController.index == 0) {
      _getDataProduct();
    } else {
      _getDataVendor();
    }
  }

  List<Product>? _dataProduct;
  List<VendorModel>? _dataVendor;

  _getDataProduct() async {
    await checkAuth(context);
    List<Product> product = await getFavoriteProduct(
      (data) => mySnackBar(
        context,
        kAccentColor,
        "Error!",
        "Item with id $data not found",
        Duration(
          seconds: 1,
        ),
      ),
    );

    setState(() {
      _dataProduct = product;
    });
  }

  _getDataVendor() async {
    await checkAuth(context);
    List<VendorModel> vendor = await getFavoriteVendor(
      (data) => mySnackBar(
        context,
        kAccentColor,
        "Error!",
        "Item with id $data not found",
        Duration(
          seconds: 1,
        ),
      ),
    );

    setState(() {
      _dataVendor = vendor;
    });
  }

  Future<void> _handleRefresh() async {
    if (_tabBarController.index == 0) {
      _getDataProduct();
    } else {
      _getDataVendor();
    }
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

//==========================================================================================\\

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

//===================== Handle refresh ==========================\\

  void _clickOnTabBarOption() async {
    if (_tabBarController.index == 0) {
      _getDataProduct();
    } else {
      _getDataVendor();
    }
  }

  //===================== Navigation ==========================\\

  void _toProductDetailsScreen(product) => Get.to(
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
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

//====================================================================================\\

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          title: "Favorites",
          elevation: 0.0,
          actions: [
            CartCard(),
          ],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: FutureBuilder(
            future: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(child: SpinKitChasingDots(color: kAccentColor));
              }
              if (snapshot.connectionState == ConnectionState.none) {
                const Center(
                  child: Text("Please connect to the internet"),
                );
              }
              // if (snapshot.connectionState == snapshot.requireData) {
              //   SpinKitChasingDots(color: kAccentColor);
              // }
              if (snapshot.connectionState == snapshot.error) {
                const Center(
                  child: Text("Error, Please try again later"),
                );
              }
              return Column(
                children: [
                  kSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Container(
                      width: mediaWidth,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    height: mediaHeight - 170,
                    width: mediaWidth,
                    child: Column(
                      children: [
                        AutoScaleTabBarView(
                          controller: _tabBarController,
                          physics: const BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          children: [
                            _dataProduct == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SpinKitChasingDots(
                                        color: kAccentColor,
                                      ),

                                    ],
                                  )
                                : Scrollbar(
                                    controller: _scrollController,
                                    radius: const Radius.circular(10),
                                    child: FavoriteProductsTab(
                                      list: _dataProduct!.isEmpty
                                          ? EmptyCard()
                                          : ListView.separated(
                                              controller: _scrollController,
                                              scrollDirection: Axis.vertical,
                                              itemCount: _dataProduct!.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      kHalfSizedBox,
                                              itemBuilder: (context, index) =>
                                                  HomeProductsCard(
                                                OnTap: () =>
                                                    _toProductDetailsScreen(
                                                        _dataProduct![index]),
                                                product: _dataProduct![index],

                                    ),
                              _dataVendor == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SpinKitChasingDots(
                                          color: kAccentColor,
                                        ),
                                      ],
                                    )
                                  : FavoriteVendorsTab(
                                      list: Scrollbar(
                                        controller: _scrollController,
                                        radius: const Radius.circular(10),
                                        child: _dataVendor!.isEmpty
                                            ? EmptyCard()
                                            : ListView.separated(
                                                controller: _scrollController,
                                                itemCount: _dataVendor!.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        kHalfSizedBox,
                                                itemBuilder: (context, index) =>
                                                    PopularVendorsCard(
                                                  onTap: () {
                                                    Get.to(
                                                      () => VendorDetails(
                                                          vendor: _dataVendor![
                                                              index]),
                                                      routeName:
                                                          'VendorDetails',
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      fullscreenDialog: true,
                                                      curve: Curves.easeIn,
                                                      preventDuplicates: true,
                                                      popGesture: true,
                                                      transition: Transition
                                                          .rightToLeft,
                                                    );
                                                  },
                                                  cardImage:
                                                      'best-choice-restaurant.png',
                                                  vendorName:
                                                      _dataVendor![index]
                                                          .shopName!,
                                                  businessType:
                                                      _dataVendor![index]
                                                          .shopType!
                                                          .name!,
                                                  rating: _dataVendor![index]
                                                      .averageRating!
                                                      .toStringAsPrecision(2),
                                                  noOfUsersRated: (_dataVendor![
                                                                  index]
                                                              .numberOfClientsReactions ??
                                                          0)
                                                      .toString(),
                                                ),

                                              ),
                                            ),
                                    ),
                                  ),
                           
                          ],
                        ),
                        kHalfSizedBox,
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
