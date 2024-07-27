// ignore_for_file: unused_field, invalid_use_of_protected_member

import 'dart:async';
import 'dart:math';

import 'package:benji/app/cart/my_cart.dart';
import 'package:benji/app/favorites/favorites.dart';
import 'package:benji/app/packages/send_package.dart';
import 'package:benji/app/support/help_and_support.dart';
import 'package:benji/src/components/business/business_card.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/components/others/empty.dart';
import 'package:benji/src/components/others/my_future_builder.dart';
import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/controller/category_controller.dart';
import 'package:benji/src/repo/controller/fcm_messaging_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/sub_category_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
import 'package:benji/src/repo/models/app_version.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
import 'package:benji/src/repo/utils/url_lunch.dart';
import 'package:benji/src/skeletons/app/card.dart';
import 'package:benji/src/skeletons/page_skeleton.dart';
import 'package:flutter/foundation.dart' as fnd;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../src/components/appbar/appbar_location.dart';
import '../../src/components/others/cart_card.dart';
import '../../src/components/product/product_card.dart';
import '../../src/components/section/category_items.dart';
import '../../src/components/section/custom_show_search.dart';
import '../../src/components/section/see_all_container.dart';
import '../../src/components/simple_item/category_item.dart';
import '../../src/components/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/controller/notifications_controller.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../theme/colors.dart';
import '../address/addresses.dart';
import '../business/business_detail_screen.dart';
import '../business/businesses_near_you.dart';
import '../business/popular_businesses.dart';
import '../orders/order_history.dart';
import '../product/home_page_products.dart';
import '../product/product_detail_screen.dart';
import '../settings/settings.dart';
import '../shopping_location/set_shopping_location.dart';
import 'home_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    // NotificationController.showNotification(
    //   title: "Welcome",
    //   body: "Nice to have you",
    //   largeIcon: "asset://assets/icons/success.png",
    //   customSound: "asset://assets/audio/benji.wav",
    // );
    checkAuth(context);
    checkIfShoppingLocation(context);
    if (!fnd.kIsWeb) {
      FcmMessagingController.instance.handleFCM();
      NotificationController.initializeNotification();

      Timer(
        const Duration(seconds: 2),
        () {
          getAppLatestVersion().then((value) {
            if (value.version == "0" || value.version == appVersion) {
              return;
            }
            showAppUpdateDialog(context, value);
          });
        },
      );
    }

    scrollController.addListener(() =>
        ProductController.instance.scrollListenerProduct(scrollController));
  }

  late Future<Address> currentAddress;

  @override
  void dispose() {
    scrollController.dispose();
    carouselController.stopAutoPlay();
    scrollController.removeListener(() {});

    super.dispose();
  }

//============================================== ALL VARIABLES =================================================\\
  int start = 0;
  int end = 10;
  bool loadMore = false;
  bool thatsAllData = false;

  String activeCategory = '';
  String cartCount = '';

//============================================== BOOL VALUES =================================================\\
  final bool _vendorStatus = true;
  bool _isScrollToTopBtnVisible = false;

  //Online businesses
  final String _onlineVendorsName = "";
  final String _onlineVendorsImage = "";
  final double _onlineVendorsRating = 0.0;

  final String _vendorActive = "Online";
  final String _vendorInactive = "Offline";
  final Color _vendorActiveColor = kSuccessColor;
  final Color _vendorInactiveColor = kAccentColor;

  //Offline businesses
  final String _offlineVendorsName = "";
  final String _offlineVendorsImage = "";
  final double _offlineVendorsRating = 0.0;

  //==================================================== CONTROLLERS ======================================================\\
  final scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();

//===================== Images =======================\\

  //===================== COPY TO CLIPBOARD =======================\\
  void _copyToClipboard(BuildContext context, String userID) {
    Clipboard.setData(
      ClipboardData(text: userID),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "ID copied to clipboard",
      const Duration(seconds: 2),
    );
  }

  //===================== Scroll to Top ==========================\\
  Future<void> _scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrollToTopBtnVisible = false;
    });
  }

  // Future<void> _scrollListener() async {
  //   if (scrollController.position.pixels >= 200 &&
  //       _isScrollToTopBtnVisible != true) {
  //     setState(() {
  //       _isScrollToTopBtnVisible = true;
  //     });
  //   }
  //   if (scrollController.position.pixels < 200 &&
  //       _isScrollToTopBtnVisible == true) {
  //     setState(() {
  //       _isScrollToTopBtnVisible = false;
  //     });
  //   }
  // }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      currentAddress = getCurrentAddress();
    });
  }

  //========================================================================\\

  //==================================================== Navigation ===========================================================\\
  void _toHelpAndSupport() => Get.to(
        () => const HelpAndSupport(),
        routeName: 'HelpAndSupport',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSettings() async {
    await Get.to(
      () => const Settings(),
      routeName: 'Settings',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    setState(() {});
  }

  void _toAddressScreen() => Get.to(
        () => const Addresses(),
        routeName: 'Addresses',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toFavoritesScreen() => Get.to(
        () => Favorites(
          vendorCoverImage:
              _vendorStatus ? _onlineVendorsImage : _offlineVendorsImage,
          vendorName: _vendorStatus ? _onlineVendorsName : _offlineVendorsName,
          vendorRating:
              _vendorStatus ? _onlineVendorsRating : _offlineVendorsRating,
          vendorActiveStatus: _vendorStatus ? _vendorActive : _vendorInactive,
          vendorActiveStatusColor:
              _vendorStatus ? _vendorActiveColor : _vendorInactiveColor,
        ),
        routeName: 'SendPackage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toOrdersScreen() => Get.to(
        () => const OrdersHistory(),
        routeName: 'OrdersHistory',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toCheckoutScreen() => Get.to(
        () => const MyCarts(),
        routeName: 'MyCarts',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSeeAllBusinessesNearYou() => Get.to(
        () => const BusinessesNearYou(),
        routeName: 'BusinessesNearYou',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toVendorPage(BusinessModel vendor) => Get.to(
        () => BusinessDetailScreen(business: vendor),
        routeName: 'BusinessDetailScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSeeAllPopularBusinesses() => Get.to(
        () => const PopularBusinesses(),
        routeName: 'PopularBusinesses',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toProductDetailScreenPage(product, [int milliseconds = 300]) async {
    await Get.to(
      () => ProductDetailScreen(product: product),
      routeName: 'ProductDetailScreen',
      duration: Duration(milliseconds: milliseconds),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.native,
    );
    setState(() {});
  }

  void _toSeeProducts(
    Category category, {
    String id = '',
  }) {
    SubCategoryController.instance.setCategory(category);
    Get.to(
      () => HomePageProducts(activeCategory: id),
      routeName: 'HomePageProducts',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void _toPackagesPage() => Get.to(
        () => const SendPackage(),
        routeName: 'SendPackage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  //=================================== Show Popup Menu =====================================\\

//Show popup menu
  void showPopupMenu(BuildContext context) {
    // final RenderBox overlay =
    //     Overlay.of(context).context.findRenderObject() as RenderBox;
    const position = RelativeRect.fromLTRB(40, 80, 40, 0);

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        PopupMenuItem<String>(
          value: 'address',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.mapLocationDot, color: kStarColor),
              kWidthSizedBox,
              const Text("Addresses"),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'shoppingLocation',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.bagShopping, color: kAccentColor),
              kWidthSizedBox,
              const Text("Shopping location"),
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'address':
            Get.to(
              () => const Addresses(),
              routeName: 'Addresses',
              duration: const Duration(milliseconds: 1000),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              preventDuplicates: true,
              popGesture: true,
              transition: Transition.cupertinoDialog,
            );
            break;
          case 'shoppingLocation':
            Get.to(
              () => const SetShoppingLocation(),
              routeName: 'SetShoppingLocation',
              duration: const Duration(milliseconds: 300),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              preventDuplicates: true,
              popGesture: true,
              transition: Transition.rightToLeft,
            );
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          setState(() {});
        },
        drawerEnableOpenDragGesture: true,
        endDrawerEnableOpenDragGesture: true,
        resizeToAvoidBottomInset: true,
        drawer: MyFutureBuilder(
          future: getUser(),
          child: (data) => HomeDrawer(
            userID: data.code,
            toSettings: _toSettings,
            copyUserIdToClipBoard: () {
              _copyToClipboard(context, data.code);
            },
            toAddressesPage: _toAddressScreen,
            toPackagesPage: _toPackagesPage,
            toFavoritesPage: _toFavoritesScreen,
            toCheckoutScreen: _toCheckoutScreen,
            toOrdersPage: _toOrdersScreen,
            helpAndSupport: _toHelpAndSupport,
          ),
        ),
        floatingActionButton: _isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                mini: deviceType(media.width) > 2 ? false : true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: FaIcon(FontAwesomeIcons.chevronUp,
                    size: 18, color: kPrimaryColor),
              )
            : const SizedBox(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0,
          toolbarHeight: kToolbarHeight,
          title: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Image.asset(
                    "assets/icons/drawer-icon.png",
                    color: kAccentColor,
                    fit: BoxFit.cover,
                    height: deviceType(media.width) > 2 ? 25 : 20,
                  ),
                ),
              ),
              GetBuilder<AddressController>(
                  initState: (state) =>
                      AddressController.instance.getCurrentAddress(),
                  builder: (controller) {
                    if (controller.isLoad.value &&
                        controller.current.value.id == '0') {
                      return AppBarLocation(
                        defaultAddress: 'Loading...',
                        onPressed: () {},
                      );
                    }
                    return AppBarLocation(
                      defaultAddress: getShoppingLocationString(),
                      onPressed: () {
                        showPopupMenu(context);
                      },
                    );
                  }),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
                width: media.width - (deviceType(media.width) > 1 ? 300 : 270),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Search',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: kAccentColor,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            kWidthSizedBox,
            // ignore: prefer_const_constructors
            CartCard(),
            kHalfWidthSizedBox
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: kAccentColor,
            semanticsLabel: "Pull to refresh",
            child: ListView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: deviceType(media.width) > 2
                  ? const EdgeInsets.all(kDefaultPadding)
                  : const EdgeInsets.all(kDefaultPadding / 2),
              children: [
                GetBuilder<ProductController>(
                  initState: (state) =>
                      ProductController.instance.getTopProducts(),
                  builder: (controller) {
                    if (controller.isLoad.value &&
                        controller.topProducts.isEmpty) {
                      return Shimmer.fromColors(
                        highlightColor: kBlackColor.withOpacity(0.9),
                        baseColor: kBlackColor.withOpacity(0.6),
                        direction: ShimmerDirection.ltr,
                        child:
                            PageSkeleton(height: 150, width: media.width - 20),
                      );
                    }
                    if (controller.topProducts.isEmpty) {
                      return const SizedBox();
                    }

                    return FlutterCarousel.builder(
                      options: CarouselOptions(
                        height: media.height * 0.25,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOut,
                        enlargeCenterPage: true,
                        controller: carouselController,
                        onPageChanged: (index, value) {
                          setState(() {});
                        },
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        scrollBehavior: const ScrollBehavior(),
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayOnManualNavigate: true,
                        pauseAutoPlayInFiniteScroll: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        disableCenter: false,
                        showIndicator: true,
                        floatingIndicator: true,
                        slideIndicator: CircularSlideIndicator(
                          alignment: Alignment.bottomCenter,
                          currentIndicatorColor: kAccentColor,
                          indicatorBackgroundColor: kPrimaryColor,
                          indicatorRadius: 5,
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                      itemCount: controller.topProducts.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: media.width,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: AssetImage(
                            //   ),
                            // ),
                          ),
                          child: InkWell(
                            onTap: () => _toProductDetailScreenPage(
                                controller.topProducts[itemIndex], 50),
                            child: MyImage(
                              url: controller
                                  .topProducts[itemIndex].productImage,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                kSizedBox,
                // categories
                Container(
                  width: media.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Today's Deals",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
                kSizedBox,
                GetBuilder<CategoryController>(
                    initState: (state) =>
                        CategoryController.instance.getCategory(),
                    builder: (controller) {
                      if (controller.isLoad.value &&
                          controller.category.isEmpty) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                    highlightColor:
                                        kBlackColor.withOpacity(0.9),
                                    baseColor: kBlackColor.withOpacity(0.6),
                                    direction: ShimmerDirection.ltr,
                                    child: PageSkeleton(
                                        height: 35, width: media.width / 9)),
                              ],
                            ),
                            kSizedBox,
                          ],
                        );
                      }
                      return LayoutGrid(
                        columnGap: 10,
                        rowGap: 10,
                        columnSizes: breakPointDynamic(
                          media.width,
                          List.filled(4, 1.fr),
                          List.filled(4, 1.fr),
                          List.filled(8, 1.fr),
                          List.filled(8, 1.fr),
                        ),
                        rowSizes: const [auto, auto],
                        children: List.generate(
                            min(8, controller.category.length + 1),
                            (index) => index).map(
                          (item) {
                            int value = min(7, controller.category.length);
                            if (item == value) {
                              return CategoryItem(
                                nav: () => showModalBottomSheet(
                                  context: context,
                                  elevation: 20,
                                  barrierColor: kBlackColor.withOpacity(0.6),
                                  showDragHandle: true,
                                  useSafeArea: true,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        kDefaultPadding,
                                      ),
                                    ),
                                  ),
                                  enableDrag: true,
                                  builder: (builder) => CategoryItemSheet(
                                      category: controller.category.value),
                                ),
                              );
                            }
                            return CategoryItem(
                              category: controller.category[item],
                              nav: () => _toSeeProducts(
                                  controller.category[item],
                                  id: controller.category[item].id),
                            );
                          },
                        ).toList(),
                      );
                    }),
                SeeAllContainer(
                  title: "Recommended businesses",
                  onPressed: _toSeeAllBusinessesNearYou,
                ),
                kSizedBox,
                GetBuilder<VendorController>(
                    initState: (state) =>
                        VendorController.instance.getVendors(),
                    builder: (controller) {
                      if (controller.isLoad.value &&
                          controller.vendorList.isEmpty) {
                        return const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CardSkeleton(height: 200, width: 200),
                              kHalfWidthSizedBox,
                              CardSkeleton(height: 200, width: 200),
                              kHalfWidthSizedBox,
                              CardSkeleton(height: 200, width: 200),
                            ],
                          ),
                        );
                      }
                      if (controller.vendorList.isNotEmpty) {
                        return SizedBox(
                          height: 250,
                          width: media.width,
                          child: ListView.separated(
                            itemCount: controller.vendorList.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                deviceType(media.width) > 2
                                    ? kWidthSizedBox
                                    : kHalfWidthSizedBox,
                            itemBuilder: (context, index) => InkWell(
                              child: SizedBox(
                                width: 200,
                                child: BusinessCard(
                                  business: controller.vendorList[index],
                                  removeDistance: false,
                                  onTap: () {
                                    _toVendorPage(controller.vendorList[index]);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const EmptyCard(
                        showButton: false,
                        emptyCardMessage:
                            "There are no recommended businesses in your location.",
                      );
                    }),
                kSizedBox,
                SeeAllContainer(
                  title: "Popular businesses",
                  onPressed: _toSeeAllPopularBusinesses,
                ),
                kSizedBox,
                GetBuilder<VendorController>(
                    initState: (state) => VendorController.instance
                        .getPopularBusinesses(start: 0, end: 4),
                    builder: (controller) {
                      if (controller.isLoad.value &&
                          controller.vendorPopularList.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.filled(
                            breakPoint(media.width, 1, 2, 3, 4).toInt(),
                            CardSkeleton(
                                height: 200,
                                width: (media.width /
                                        breakPoint(media.width, 1, 2, 3, 4)) -
                                    20),
                          ),
                        );
                      }
                      if (controller.vendorPopularList.isNotEmpty) {
                        return LayoutGrid(
                          rowGap: kDefaultPadding / 2,
                          columnGap: kDefaultPadding / 2,
                          columnSizes: breakPointDynamic(
                              media.width,
                              [1.fr],
                              [1.fr, 1.fr],
                              [1.fr, 1.fr, 1.fr],
                              [1.fr, 1.fr, 1.fr, 1.fr]),
                          rowSizes: controller.vendorPopularList
                                  .getRange(
                                      0,
                                      min(controller.vendorPopularList.length,
                                          3))
                                  .isEmpty
                              ? [auto]
                              : List.generate(
                                  controller.vendorPopularList
                                      .getRange(
                                          0,
                                          min(
                                              controller
                                                  .vendorPopularList.length,
                                              3))
                                      .length,
                                  (index) => auto),
                          children: (controller.vendorPopularList.getRange(0,
                                  min(controller.vendorPopularList.length, 3)))
                              .map(
                                (item) => BusinessCard(
                                  business: item,
                                  removeDistance: true,
                                  onTap: () {
                                    _toVendorPage(item);
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }
                      return const EmptyCard(
                        showButton: false,
                        emptyCardMessage:
                            "There are no popular vendors available.",
                      );
                    }),
                kSizedBox,
                Container(
                  width: media.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Products Category".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
                kSizedBox,
                GetBuilder<CategoryController>(
                    initState: (state) =>
                        CategoryController.instance.getCategory(),
                    builder: (controller) {
                      if (controller.isLoad.value &&
                          controller.category.isEmpty) {
                        return Column(
                          children: [
                            kSizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                  highlightColor: kBlackColor.withOpacity(0.9),
                                  baseColor: kBlackColor.withOpacity(0.6),
                                  direction: ShimmerDirection.ltr,
                                  child: PageSkeleton(
                                      height: 35, width: media.width / 7),
                                ),
                                kWidthSizedBox,
                                Shimmer.fromColors(
                                    highlightColor:
                                        kBlackColor.withOpacity(0.9),
                                    baseColor: kBlackColor.withOpacity(0.6),
                                    direction: ShimmerDirection.ltr,
                                    child: PageSkeleton(
                                        height: 35, width: media.width / 9)),
                              ],
                            ),
                            kSizedBox,
                          ],
                        );
                      }

                      return LayoutGrid(
                        columnGap: 10,
                        rowGap: 10,
                        columnSizes: breakPointDynamic(
                          media.width,
                          List.filled(4, 1.fr),
                          List.filled(4, 1.fr),
                          List.filled(8, 1.fr),
                          List.filled(8, 1.fr),
                        ),
                        rowSizes: const [auto, auto],
                        children: List.generate(
                            min(8, controller.category.length + 1),
                            (index) => index).map(
                          (item) {
                            int value = min(7, controller.category.length);
                            if (item == value) {
                              return CategoryItem(
                                nav: () => showModalBottomSheet(
                                  context: context,
                                  elevation: 20,
                                  barrierColor: kBlackColor.withOpacity(0.6),
                                  showDragHandle: true,
                                  useSafeArea: true,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        kDefaultPadding,
                                      ),
                                    ),
                                  ),
                                  enableDrag: true,
                                  builder: (builder) => CategoryItemSheet(
                                      isShop: false,
                                      category: controller.category),
                                ),
                              );
                            }
                            return CategoryItem(
                              isShop: false,
                              category: controller.category[item],
                              nav: () => _toSeeProducts(
                                  controller.category[item],
                                  id: controller.category[item].id),
                            );
                          },
                        ).toList(),
                      );
                    }),
                kSizedBox,

                GetBuilder<ProductController>(
                  initState: (state) => ProductController.instance.getProduct(),
                  builder: (controller) {
                    if (controller.isLoad.value &&
                        controller.products.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.filled(
                          breakPoint(media.width, 1, 2, 3, 4).toInt(),
                          CardSkeleton(
                              height: 200,
                              width: (media.width /
                                      breakPoint(media.width, 1, 2, 3, 4)) -
                                  20),
                        ),
                      );
                    }
                    if (controller.products.isNotEmpty) {
                      return Column(
                        children: [
                          LayoutGrid(
                            rowGap: kDefaultPadding / 2,
                            columnGap: kDefaultPadding / 2,
                            columnSizes: breakPointDynamic(
                                media.width,
                                [1.fr],
                                [1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr, 1.fr]),
                            rowSizes: controller.products.isEmpty
                                ? [auto]
                                : List.generate(controller.products.length,
                                    (index) => auto),
                            children: (controller.products)
                                .map(
                                  (item) => ProductCard(
                                    product: item,
                                    onTap: () =>
                                        _toProductDetailScreenPage(item),
                                  ),
                                )
                                .toList(),
                          ),
                          kHalfSizedBox,
                          controller.loadedAllProduct.value
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 10,
                                  width: 10,
                                  decoration: ShapeDecoration(
                                      shape: const CircleBorder(),
                                      color: kPageSkeletonColor),
                                )
                              : const SizedBox(),
                          controller.isLoadMoreProduct.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: kAccentColor,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    }
                    return const EmptyCard(
                      showButton: false,
                      emptyCardMessage: "There are no products available",
                    );
                  },
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

void showAppUpdateDialog(context, AppVersion appVersion) {
  showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            "UPDATE!".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            "Please update your app",
            textAlign: TextAlign.center,
            maxLines: 4,
            style: TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            MyElevatedButton(
              title: "Okay",
              onPressed: () {
                launchDownload(appVersion.link);
              },
            ),
          ],
        ),
      );
    },
  );
}
