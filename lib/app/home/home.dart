// ignore_for_file: unused_field

import 'package:benji_user/app/favorites/favorites.dart';
import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:benji_user/src/others/my_future_builder.dart';
import 'package:benji_user/src/repo/models/address_model.dart';
import 'package:benji_user/src/repo/models/category/category.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/appBar_delivery_location.dart';
import '../../src/common_widgets/button/category button.dart';
import '../../src/common_widgets/cart.dart';
import '../../src/common_widgets/product/home_products_card.dart';
import '../../src/common_widgets/section/custom_showSearch.dart';
import '../../src/common_widgets/section/see_all_container.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/vendor/popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/product/product.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../src/repo/utils/cart.dart';
import '../../theme/colors.dart';
import '../address/addresses.dart';
import '../address/deliver_to.dart';
import '../auth/login.dart';
import '../orders/order_history.dart';
import '../product/product_detail_screen.dart';
import '../product/products.dart';
import '../profile_settings/profile_settings.dart';
import '../send_package/send_package.dart';
import '../vendor/popular_vendors.dart';
import '../vendor/vendor_details.dart';
import '../vendor/vendors_near_you.dart';
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
    _getData();
    countCartFunc();
  }

  countCartFunc() async {
    String data = await countCart();
    setState(() {
      cartCount = data;
    });
  }

  Map? _data;
  List<Product>? product;
  _getData() async {
    await checkAuth(context);
    String current = 'Select Address';
    try {
      current = (await getCurrentAddress()).streetAddress ?? current;
    } catch (e) {
      current = current;
    }

    product = [];
    List<Category> category = await getCategories();
    try {
      product = await getProductsByCategory(category[activeCategory].id);
    } catch (e) {
      product = [];
    }
    List<VendorModel> vendor = await getVendors();
    setState(() {
      _data = {
        'category': category,
        'product': product,
        'vendor': vendor,
        'currentAddress': current,
      };
    });
  }

  //=======================================================================================================================================\\

//============================================== ALL VARIABLES =================================================\\
  int activeCategory = 0;
  String cartCount = '';
//============================================== BOOL VALUES =================================================\\
  bool _vendorStatus = true;

  //Online Vendors
  final String _onlineVendorsName = "Ntachi Osa";
  final String _onlineVendorsImage = "ntachi-osa";
  final double _onlineVendorsRating = 4.6;

  final String _vendorActive = "Online";
  final String _vendorInactive = "Offline";
  final Color _vendorActiveColor = kSuccessColor;
  final Color _vendorInactiveColor = kAccentColor;

  //Offline Vendors
  final String _offlineVendorsName = "Best Choice Restaurant";
  final String _offlineVendorsImage = "best-choice-restaurant";
  final double _offlineVendorsRating = 4.0;

  //==================================================== CONTROLLERS ======================================================\\
  TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();

//===================== POPULAR VENDORS =======================\\
  final List<String> popularVendorImage = [
    "best-choice-restaurant.png",
    "golden-toast.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
  ];

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
      Duration(
        seconds: 2,
      ),
    );
  }

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }
  //========================================================================\\

  //==================================================== Navigation ===========================================================\\
  void _logOut() => Get.offAll(
        () => const Login(logout: true),
        predicate: (route) => false,
        routeName: 'Login',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.downToUp,
      );

  void _toProfileSettings() async {
    await Get.to(
      () => const ProfileSettings(),
      routeName: 'ProfileSettings',
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
  void _toSendPackageScreen() => Get.to(
        () => const SendPackage(),
        routeName: 'SendPackage',
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
        () => const DeliverTo(),
        routeName: 'DeliverTo',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
  void _toSeeAllVendorsNearYou() => Get.to(
        () => const VendorsNearYou(),
        routeName: 'VendorsNearYou',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toVendorPage(VendorModel vendor) => Get.to(
        () => VendorDetails(vendor: vendor),
        routeName: 'VendorDetails',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSeeAllPopularVendors() => Get.to(
        () => const PopularVendors(),
        routeName: 'PopularVendors',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
  void _toAddressesPage() => Get.to(
        () => const Addresses(),
        routeName: 'Addresses',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toProductDetailScreenPage(product) async {
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
    setState(() {});
  }

  void _toSeeProducts() => Get.to(
        () => const HomePageProducts(),
        routeName: 'HomePageProducts',
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
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          setState(() {});
        },
        drawerDragStartBehavior: DragStartBehavior.start,
        drawerEnableOpenDragGesture: true,
        drawer: MyFutureBuilder(
          future: getUser(),
          child: (data) => HomeDrawer(
            userID: data.code,
            toProfileSettings: _toProfileSettings,
            copyUserIdToClipBoard: () {
              _copyToClipboard(context, data.code);
            },
            toAddressesPage: _toAddressScreen,
            toSendPackagePage: _toSendPackageScreen,
            toFavoritesPage: _toFavoritesScreen,
            toCheckoutScreen: _toCheckoutScreen,
            toOrdersPage: _toOrdersScreen,
            logOut: _logOut,
          ),
        ),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0.0,
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
                    height: 20,
                  ),
                ),
              ),
              AppBarDeliveryLocation(
                deliveryLocation:
                    _data != null ? _data!['currentAddress'] : 'Select Address',
                toDeliverToPage: _toAddressesPage,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: kAccentColor,
              ),
            ),
            CartCard()
          ],
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
                  onRefresh: _handleRefresh,
                  color: kAccentColor,
                  semanticsLabel: "Pull to refresh",
                  child: Scrollbar(
                    controller: _scrollController,
                    radius: Radius.circular(10),
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      children: [
                        SeeAllContainer(
                          title: "Vendors Near you",
                          onPressed: _toSeeAllVendorsNearYou,
                        ),
                        kSizedBox,
                        SizedBox(
                          height: 250,
                          width: mediaWidth,
                          child: ListView.separated(
                            itemCount: _data!['vendor'].length,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                kHalfWidthSizedBox,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                _toVendorPage(_data!['vendor'][index]);
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 224,
                                      height: 128,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/vendors/ntachi-osa.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7.20),
                                          topRight: Radius.circular(7.20),
                                        ),
                                      ),
                                    ),
                                    kHalfSizedBox,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              _data!['vendor'][index].shopName,
                                              style: TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: -0.40,
                                              ),
                                            ),
                                          ),
                                          kHalfSizedBox,
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              _data!['vendor'][index]
                                                      .shopType
                                                      .name ??
                                                  'Not Available',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: kTextGreyColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          kHalfSizedBox,
                                          Container(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.solidStar,
                                                  color: kStarColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 4.0),
                                                SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    '${((_data!['vendor'][index].averageRating as double?) ?? 0.0).toStringAsPrecision(2)} (${_data!['vendor'][index].numberOfClientsReactions ?? 0}+)',
                                                    style: TextStyle(
                                                      color: kTextBlackColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: -0.28,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                FaIcon(
                                                  FontAwesomeIcons.solidClock,
                                                  color: kAccentColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 4.0),
                                                SizedBox(
                                                  width: 60,
                                                  child: Text(
                                                    '30 mins',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: kTextBlackColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: -0.28,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        kHalfSizedBox,
                        SeeAllContainer(
                          title: "Popular Vendors",
                          onPressed: _toSeeAllPopularVendors,
                        ),
                        kSizedBox,
                        Center(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _data!['vendor'].length,
                            separatorBuilder: (context, index) => kHalfSizedBox,
                            itemBuilder: (context, index) => PopularVendorsCard(
                              onTap: () {
                                _toVendorPage(
                                  _data!['vendor'][index],
                                );
                              },
                              cardImage: popularVendorImage[index],
                              vendorName: _data!['vendor'][index].shopName,
                              businessType:
                                  _data!['vendor'][index].shopType.name ??
                                      'Not Available',
                              rating: ((_data!['vendor'][index].averageRating
                                          as double?) ??
                                      0.0)
                                  .toStringAsPrecision(2)
                                  .toString(),
                              noOfUsersRated: (_data!['vendor'][index]
                                          .numberOfClientsReactions ??
                                      0)
                                  .toString(),
                            ),
                          ),
                        ),
                        kSizedBox,
                        SeeAllContainer(
                          title: "Products",
                          onPressed: _toSeeProducts,
                        ),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            itemCount: _data!['category'].length,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.all(10),
                              child: CategoryButton(
                                onPressed: () {
                                  setState(() {
                                    activeCategory = index;
                                    product = null;
                                    _getData();
                                  });
                                },
                                title: _data!['category'][index].name,
                                bgColor: index == activeCategory
                                    ? kAccentColor
                                    : kDefaultCategoryBackgroundColor,
                                categoryFontColor: index == activeCategory
                                    ? kPrimaryColor
                                    : kTextGreyColor,
                              ),
                            ),
                          ),
                        ),
                        kSizedBox,
                        Center(
                          child: product == null
                              ? Center(
                                  child:
                                      SpinKitChasingDots(color: kAccentColor))
                              : _data!['product'].isEmpty
                                  ? EmptyCard(
                                      removeButton: true,
                                    )
                                  : ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _data!['product'].length,
                                      separatorBuilder: (context, index) =>
                                          kHalfSizedBox,
                                      itemBuilder: (context, index) =>
                                          HomeProductsCard(
                                        product: _data!['product'][index],
                                        OnTap: () => _toProductDetailScreenPage(
                                            _data!['product'][index]),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
