// ignore_for_file: unused_local_variable

import 'package:benji_user/app/cart/cart_screen.dart';
import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../src/common_widgets/vendor/popular_vendors_card.dart';
import '../../src/common_widgets/vendor/vendors_food_container.dart';
import '../../src/providers/constants.dart';
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
    _loadingScreen = false;
    _loadingScreen = true;
    Future.delayed(
      const Duration(milliseconds: 1000),
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

//===================== BOOL VALUES =======================\\
  // bool isLoading = false;
  late bool _loadingScreen;
  bool _loadingTabBarContent = false;

  //=================================== Orders =======================================\\

  // final String _orderItem = "Jollof Rice and Chicken";
  // final String _customerAddress = "21 Odogwu Street, New Haven";
  // final int _itemQuantity = 2;
  // // final double _price = 2500;
  // final double _itemPrice = 2500;
  // final String _orderImage = "chizzy's-food";
  // final String _customerName = "Mercy Luke";

  // //=============================== Products ====================================\\
  // final String _productName = "Smokey Jollof Pasta";
  // final String _productImage = "pasta";
  // final String _productDescription =
  //     "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos  sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis  minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit  quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur  fugiat, temporibus enim commodi iusto libero magni deleniti quod quam consequuntur! Commodi minima excepturi repudiandae velit hic maxime doloremque. Quaerat provident commodi consectetur veniam similique ad earum omnis ipsum saepe, voluptas, hic voluptates pariatur est explicabo fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam totam ratione voluptas quod exercitationem fuga. Possim";
  // final double _productPrice = 1200;

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FUNCTIONS =======================\\
  // double calculateSubtotal() {
  //   return _itemPrice * _itemQuantity;
  // }

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

  void _clickOnTabBarOption() async {
    setState(() {
      _loadingTabBarContent = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _loadingTabBarContent = false;
    });
  }

  //===================== Navigation ==========================\\
  void _toCartScreen() => Get.to(
        () => const CartScreen(),
        routeName: 'CartScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toProductDetailsScreen() => Get.to(
        () => const ProductDetailScreen(),
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

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: kAccentColor,
      borderWidth: 5.0,
      backgroundColor: kPrimaryColor,
      height: 150,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          title: "Favorites",
          elevation: 0.0,
          actions: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: _toCartScreen,
                    splashRadius: 20,
                    icon: FaIcon(
                      FontAwesomeIcons.cartShopping,
                      size: 18,
                      color: kAccentColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: ShapeDecoration(
                      color: kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "10+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              return _loadingScreen
                  ? Center(child: SpinKitChasingDots(color: kAccentColor))
                  : Column(
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
                                    splashBorderRadius:
                                        BorderRadius.circular(50),
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
                            horizontal: kDefaultPadding,
                          ),
                          height: mediaHeight - 170,
                          width: mediaWidth,
                          child: Column(
                            children: [
                              Expanded(
                                child: TabBarView(
                                  controller: _tabBarController,
                                  clipBehavior: Clip.hardEdge,
                                  physics: const BouncingScrollPhysics(),
                                  dragStartBehavior: DragStartBehavior.down,
                                  children: [
                                    _loadingTabBarContent
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SpinKitChasingDots(
                                                color: kAccentColor,
                                              ),
                                            ],
                                          )
                                        : Scrollbar(
                                            controller: _scrollController,
                                            radius: const Radius.circular(10),
                                            trackVisibility: true,
                                            child: FavoriteProductsTab(
                                              list: ListView.separated(
                                                controller: _scrollController,
                                                scrollDirection: Axis.vertical,
                                                itemCount: 20,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        kHalfSizedBox,
                                                itemBuilder: (context, index) =>
                                                    VendorFoodContainer(
                                                  onTap:
                                                      _toProductDetailsScreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                    _loadingTabBarContent
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
                                              trackVisibility: true,
                                              child: ListView.separated(
                                                controller: _scrollController,
                                                itemCount: 20,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        kHalfSizedBox,
                                                itemBuilder: (context, index) =>
                                                    PopularVendorsCard(
                                                  onTap: () {},
                                                  cardImage:
                                                      'best-choice-restaurant.png',
                                                  vendorName:
                                                      "Best Choice restaurant",
                                                  food: "Food",
                                                  rating: "3.6",
                                                  noOfUsersRated: "500",
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
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
