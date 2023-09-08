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
  }

  Future<Map> _getData() async {
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

    return {'product': product, 'vendor': vendor};
  }

  Future<void> _handleRefresh() async {
    // setState(() {});
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

  void _clickOnTabBarOption() async {}

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
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Text("Please connect to the internet"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Center(child: SpinKitChasingDots(color: kAccentColor));
              }
              // if (snapshot.connectionState == snapshot.requireData) {
              //   SpinKitChasingDots(color: kAccentColor);
              // }
              if (snapshot.connectionState == snapshot.error) {
                return Center(
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
                    width: mediaWidth,
                    child: Column(
                      children: [
                        AutoScaleTabBarView(
                          controller: _tabBarController,
                          physics: const BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          children: [
                            Scrollbar(
                                controller: _scrollController,
                                radius: const Radius.circular(10),
                                child: FavoriteProductsTab(
                                  list: snapshot.data!['product'].isEmpty
                                      ? EmptyCard()
                                      : ListView.separated(
                                          controller: _scrollController,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              snapshot.data!['product'].length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              kHalfSizedBox,
                                          itemBuilder: (context, index) =>
                                              HomeProductsCard(
                                            OnTap: () =>
                                                _toProductDetailsScreen(snapshot
                                                    .data!['product'][index]),
                                            product: snapshot.data!['product']
                                                [index],
                                          ),
                                        ),
                                )),
                            FavoriteVendorsTab(
                              list: Scrollbar(
                                controller: _scrollController,
                                radius: const Radius.circular(10),
                                child: snapshot.data!['vendor'].isEmpty
                                    ? EmptyCard()
                                    : ListView.separated(
                                        controller: _scrollController,
                                        itemCount:
                                            snapshot.data!['vendor'].length,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            kHalfSizedBox,
                                        itemBuilder: (context, index) =>
                                            PopularVendorsCard(
                                          onTap: () {
                                            Get.to(
                                              () => VendorDetails(
                                                  vendor: snapshot
                                                      .data!['vendor'][index]),
                                              routeName: 'VendorDetails',
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              fullscreenDialog: true,
                                              curve: Curves.easeIn,
                                              preventDuplicates: true,
                                              popGesture: true,
                                              transition:
                                                  Transition.rightToLeft,
                                            );
                                          },
                                          cardImage:
                                              'best-choice-restaurant.png',
                                          vendorName: snapshot
                                              .data!['vendor'][index].shopName!,
                                          businessType: snapshot
                                              .data!['vendor'][index]
                                              .shopType!
                                              .name!,
                                          rating: snapshot
                                              .data!['vendor'][index]
                                              .averageRating!
                                              .toStringAsPrecision(2),
                                          noOfUsersRated: (snapshot
                                                      .data!['vendor'][index]
                                                      .numberOfClientsReactions ??
                                                  0)
                                              .toString(),
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
