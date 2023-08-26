import 'package:benji_user/app/favorites/favorites.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/appBar_delivery_location.dart';
import '../../src/common_widgets/product/hot_deals_card.dart';
import '../../src/common_widgets/section/category_button_section.dart';
import '../../src/common_widgets/section/custom_showSearch.dart';
import '../../src/common_widgets/section/see_all_container.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/vendor/homepage_vendors.dart';
import '../../src/common_widgets/vendor/popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../address/addresses.dart';
import '../address/deliver_to.dart';
import '../auth/login.dart';
import '../cart/cart_screen.dart';
import '../checkout/checkout_screen.dart';
import '../orders/order_history.dart';
import '../product/hot_deals_page.dart';
import '../profile/edit_profile.dart';
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

    _loadingScreen = true;
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }
  //=======================================================================================================================================\\

//============================================== ALL VARIABLES =================================================\\

//============================================== BOOL VALUES =================================================\\
  late bool _loadingScreen;
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
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();

  //==================================================== CATEGORY BUTTONS ======================================================\\
  final List _categoryButton = [
    "Food",
    "Drinks",
    "Groceries",
    "Pharmaceuticals",
    "Snacks",
  ];

  final List<Color> _categoryButtonBgColor = [
    kAccentColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor,
    kDefaultCategoryBackgroundColor,
  ];
  final List<Color> _categoryButtonFontColor = [
    kPrimaryColor,
    kTextGreyColor,
    kTextGreyColor,
    kTextGreyColor,
    kTextGreyColor,
  ];

//===================== POPULAR VENDORS =======================\\
  final List<int> popularVendorsIndex = [0, 1, 2, 3, 4];

  final List<String> popularVendorImage = [
    "best-choice-restaurant.png",
    "golden-toast.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
  ];

  final List<String> popularVendorName = [
    "Best Choice restaurant",
    "Golden Toast",
    "Best Choice restaurant",
    "Best Choice restaurant",
    "Best Choice restaurant",
  ];

  final List<String> popularVendorFood = [
    "Food",
    "Traditional",
    "Food",
    "Food",
    "Food",
  ];

  final List<String> popularVendorRating = [
    "3.6",
    "3.6",
    "3.6",
    "3.6",
    "3.6",
  ];
  final List<String> popularVendorNoOfUsersRating = [
    "500",
    "500",
    "500",
    "500",
    "500",
  ];

  //===================== COPY TO CLIPBOARD =======================\\
  final String userID = 'ID: 337890-AZQ';
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: userID,
      ),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
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
      _loadingScreen = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _loadingScreen = false;
    });
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

  void _toProfileSettings() => Get.to(
        () => const EditProfile(),
        routeName: 'EditProfile',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

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
        () => const CheckoutScreen(),
        routeName: 'CheckoutScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

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

  void _toVendorPage() => Get.to(
        () => const VendorDetails(),
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
  void _toDeliverToPage() => Get.to(
        () => const DeliverTo(),
        routeName: 'DeliverTo',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSeeAllHotDeals() => Get.to(
        () => const HotDealsPage(),
        routeName: 'HotDealsPage',
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
        drawerDragStartBehavior: DragStartBehavior.start,
        drawerEnableOpenDragGesture: true,
        drawer: HomeDrawer(
          userID: userID,
          toEditProfilePage: _toProfileSettings,
          copyUserIdToClipBoard: () {
            _copyToClipboard(context);
          },
          toAddressesPage: _toAddressScreen,
          toSendPackagePage: _toSendPackageScreen,
          toFavoritesPage: _toFavoritesScreen,
          toCheckoutScreen: _toCheckoutScreen,
          toOrdersPage: _toOrdersScreen,
          logOut: _logOut,
        ),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          titleSpacing: kDefaultPadding / 2,
          elevation: 0.0,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
                child: Builder(
                  builder: (context) => IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Image.asset(
                      "assets/images/icons/drawer-icon.png",
                      color: kAccentColor,
                      fit: BoxFit.cover,
                      height: 20,
                    ),
                  ),
                ),
              ),
              AppBarDeliveryLocation(
                deliveryLocation: 'Independence Layout, Enugu',
                toDeliverToPage: _toDeliverToPage,
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
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: _toCartScreen,
                    splashRadius: 20,
                    icon: FaIcon(
                      FontAwesomeIcons.cartShopping,
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
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            color: kPrimaryColor,
            width: mediaWidth,
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHalfSizedBox,
                _loadingScreen
                    ? SizedBox()
                    : CategoryButtonSection(
                        category: _categoryButton,
                        categorybgColor: _categoryButtonBgColor,
                        categoryFontColor: _categoryButtonFontColor,
                      ),
                SizedBox(height: 8),
                _loadingScreen
                    ? SpinKitChasingDots(color: kAccentColor)
                    : Flexible(
                        fit: FlexFit.loose,
                        child: Scrollbar(
                          controller: _scrollController,
                          radius: Radius.circular(10),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: RefreshIndicator(
                            onRefresh: _handleRefresh,
                            color: kAccentColor,
                            edgeOffset: 0,
                            displacement: 0.0,
                            semanticsLabel: "Pull to refresh",
                            strokeWidth: 3.0,
                            triggerMode: RefreshIndicatorTriggerMode.onEdge,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: [
                                SeeAllContainer(
                                  title: "Vendors Near you",
                                  onPressed: _toSeeAllVendorsNearYou,
                                ),
                                kSizedBox,
                                HomePageVendorsNearYou(
                                  onTap: _toVendorPage,
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
                                    padding: EdgeInsets.only(
                                      left: kDefaultPadding / 2,
                                      right: kDefaultPadding / 2,
                                    ),
                                    itemCount: popularVendorsIndex.length,
                                    separatorBuilder: (context, index) =>
                                        kHalfSizedBox,
                                    itemBuilder: (context, index) =>
                                        PopularVendorsCard(
                                      onTap: () {},
                                      cardImage: popularVendorImage[index],
                                      vendorName: popularVendorName[index],
                                      food: popularVendorFood[index],
                                      rating: popularVendorRating[index],
                                      noOfUsersRated:
                                          popularVendorNoOfUsersRating[index],
                                    ),
                                  ),
                                ),
                                kSizedBox,
                                SeeAllContainer(
                                  title: "Hot Deals",
                                  onPressed: _toSeeAllHotDeals,
                                ),
                                kSizedBox,
                                Center(
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      left: kDefaultPadding / 2,
                                      right: kDefaultPadding / 2,
                                    ),
                                    itemCount: 10,
                                    separatorBuilder: (context, index) =>
                                        kHalfSizedBox,
                                    itemBuilder: (context, index) =>
                                        HotDealsCard(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
