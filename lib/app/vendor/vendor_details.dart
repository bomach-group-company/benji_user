import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/section/category_button_section.dart';
import '../../src/common_widgets/section/custom_showSearch.dart';
import '../../src/common_widgets/section/rate_vendor_dialog.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/vendor/vendor_about_tab.dart';
import '../../src/common_widgets/vendor/vendor_products_tab.dart';
import '../../src/common_widgets/vendor/vendors_product_container.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../theme/colors.dart';
import '../product/product_detail_screen.dart';
import 'about_vendor.dart';
import 'all_vendor_products.dart';
import 'report_vendor.dart';
import 'vendor_location.dart';

class VendorDetails extends StatefulWidget {
  final String id;
  const VendorDetails({super.key, this.id = '4'});

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails>
    with SingleTickerProviderStateMixin {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _getData();

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

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

//===================== BOOL VALUES =======================\\
  late bool _loadingScreen;
  bool _loadingTabBarContent = false;
  bool _isAddedToFavorites = false;

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
  Map? _data;

  _getData() async {
    // VendorModel vendor = await getVendorById(widget.vendorId);
    // _data = {'vendor': vendor};
  }

  void validate() {
    mySnackBar(
      context,
      "Success!",
      "Thank you for your feedback!",
      Duration(seconds: 1),
    );

    Get.back();
  }

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
  void _addToFavorites() {
    setState(() {
      _isAddedToFavorites = !_isAddedToFavorites;
    });

    mySnackBar(
      context,
      "Success",
      _isAddedToFavorites
          ? "Vendor has been added to favorites"
          : "Vendor been removed from favorites",
      Duration(milliseconds: 500),
    );
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

//=================================== Show Popup Menu =====================================\\

//Show popup menu
  void showPopupMenu(BuildContext context) {
    // final RenderBox overlay =
    //     Overlay.of(context).context.findRenderObject() as RenderBox;
    const position = RelativeRect.fromLTRB(10, 60, 0, 0);

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        PopupMenuItem<String>(
          value: 'rate',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(FontAwesomeIcons.solidStar, color: kStarColor),
              Text("Rate this vendor"),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'report',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(FontAwesomeIcons.solidFlag, color: kAccentColor),
              Text("Report this vendor"),
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'rate':
            openRatingDialog(context);
            break;
          case 'report':
            Get.to(
              () => ReportVendor(),
              routeName: 'ReportVendor',
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

//================================ Rating Dialog ======================================\\
  openRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding)),
          elevation: 50,
          child: RateVendorDialog(),
        );
      },
    );
  }

//=================================== Navigation =====================================\\

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

  void _toVendorLocation() => Get.to(
        () => VendorLocation(),
        routeName: 'VendorLocation',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _viewProducts() => Get.to(
        () => AllVendorProducts(),
        routeName: 'AllVendorProducts',
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
    double mediaHeight = MediaQuery.of(context).size.height;

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBody: true,
        appBar: MyAppBar(
          title: "Vendor Details",
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          toolbarHeight: 40,
          actions: [
            IconButton(
              onPressed: () {
                _loadingScreen
                    ? null
                    : showSearch(
                        context: context, delegate: CustomSearchDelegate());
              },
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: kAccentColor,
              ),
            ),
            IconButton(
              onPressed: _loadingScreen ? null : _addToFavorites,
              icon: FaIcon(
                _isAddedToFavorites
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: kAccentColor,
              ),
            ),
            IconButton(
              onPressed: () => _loadingScreen ? null : showPopupMenu(context),
              icon: FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: kAccentColor,
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
<<<<<<< HEAD:lib/app/vendors/vendor_details.dart
          child: Scrollbar(
            controller: _scrollController,
            radius: const Radius.circular(10),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                SizedBox(
                  height: 340,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: kPageSkeletonColor,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/vendors/ntachi-osa.png",
=======
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
                    : Scrollbar(
                        controller: _scrollController,
                        radius: const Radius.circular(10),
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView(
                          physics: const ScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 340,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                        color: kPageSkeletonColor,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            "assets/images/vendors/ntachi-osa.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.13,
                                    left: kDefaultPadding,
                                    right: kDefaultPadding,
                                    child: Container(
                                      width: 200,
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 2),
                                      decoration: ShapeDecoration(
                                        shadows: [
                                          BoxShadow(
                                            color: kBlackColor.withOpacity(0.1),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.normal,
                                          ),
                                        ],
                                        color: const Color(0xFFFEF8F8),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFFDEDED),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: kDefaultPadding * 2.6),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: mediaWidth - 200,
                                              child: Text(
                                                "Ntachi Osa",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: kTextBlackColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            kHalfSizedBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: kAccentColor,
                                                  size: 15,
                                                ),
                                                kHalfWidthSizedBox,
                                                SizedBox(
                                                  width: mediaWidth - 100,
                                                  child: Text(
                                                    "Old Abakaliki Rd, Thinkers Corner 400103, Enugu",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            kHalfSizedBox,
                                            InkWell(
                                              onTap: _toVendorLocation,

                                              // (() async {
                                              //   final websiteurl = Uri.parse(
                                              //     "https://goo.gl/maps/8pKoBVCsew5oqjU49",
                                              //   );
                                              //   if (await canLaunchUrl(
                                              //     websiteurl,
                                              //   )) {
                                              //     launchUrl(
                                              //       websiteurl,
                                              //       mode: LaunchMode
                                              //           .externalNonBrowserApplication,
                                              //     );
                                              //   } else {
                                              //     throw "An unexpected error occured and $websiteurl cannot be loaded";
                                              //   }
                                              // }),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: mediaWidth / 4,
                                                padding: const EdgeInsets.all(
                                                    kDefaultPadding / 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: kAccentColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Show on map",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            kHalfSizedBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: mediaWidth * 0.23,
                                                  height: 57,
                                                  decoration: ShapeDecoration(
                                                    color: kPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              19),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .solidStar,
                                                        color: kStarColor,
                                                        size: 17,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        "4.8",
                                                        style: const TextStyle(
                                                          color: kBlackColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: -0.28,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: mediaWidth * 0.25,
                                                  height: 57,
                                                  decoration: ShapeDecoration(
                                                    color: kPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              19),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Online",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: kSuccessColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: -0.36,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      FaIcon(
                                                        Icons.info,
                                                        color: kAccentColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.07,
                                    left:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: ShapeDecoration(
                                        color: kPageSkeletonColor,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            "assets/images/vendors/ntachi-osa-logo.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                ],
>>>>>>> main:lib/app/vendor/vendor_details.dart
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.13,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: ShapeDecoration(
                            shadows: [
                              BoxShadow(
                                color: kBlackColor.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                            color: const Color(0xFFFEF8F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFFDEDED),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: kDefaultPadding * 2.6),
                            child: Column(
                              children: [
                                Text(
                                  "Ntachi-Osa",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      color: kAccentColor,
                                      size: 15,
                                    ),
                                    kHalfWidthSizedBox,
                                    SizedBox(
                                      width: mediaWidth - 100,
                                      child: Text(
                                        "Old Abakaliki Rd, Thinkers Corner 400103, Enugu",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                kHalfSizedBox,
                                InkWell(
                                  onTap: (() async {
                                    final websiteurl = Uri.parse(
                                      "https://goo.gl/maps/8pKoBVCsew5oqjU49",
                                    );
                                    if (await canLaunchUrl(
                                      websiteurl,
                                    )) {
                                      launchUrl(
                                        websiteurl,
                                        mode: LaunchMode
                                            .externalNonBrowserApplication,
                                      );
                                    } else {
                                      throw "An unexpected error occured and $websiteurl cannot be loaded";
                                    }
                                  }),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: mediaWidth / 4,
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: kAccentColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text(
                                      "Show on map",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: mediaWidth * 0.23,
                                      height: 57,
                                      decoration: ShapeDecoration(
                                        color: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.solidStar,
                                            color: kStarColor,
                                            size: 17,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "4.8",
                                            style: const TextStyle(
                                              color: kBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: mediaWidth * 0.25,
                                      height: 57,
                                      decoration: ShapeDecoration(
                                        color: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Online",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kSuccessColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.36,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          FaIcon(
                                            Icons.info,
                                            color: kAccentColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.07,
                        left: MediaQuery.of(context).size.width / 2.7,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: ShapeDecoration(
                            color: kPageSkeletonColor,
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/vendors/ntachi-osa-logo.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            dragStartBehavior: DragStartBehavior.start,
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
                              Tab(text: "About"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                Container(
                  constraints: BoxConstraints(
                    maxHeight: mediaHeight + mediaHeight + 120,
                  ),
                  width: mediaWidth,
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 2,
                    right: kDefaultPadding / 2,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _tabBarController,
                          physics: const BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          children: [
                            _loadingTabBarContent
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SpinKitChasingDots(
                                        color: kAccentColor,
                                      ),
                                    ],
                                  )
                                : VendorsProductsTab(
                                    list: Column(
                                      children: [
<<<<<<< HEAD:lib/app/vendors/vendor_details.dart
                                        CategoryButtonSection(
                                          category: _categoryButtonText,
                                          categoryFontColor:
                                              _categoryButtonFontColor,
                                          categorybgColor:
                                              _categoryButtonBgColor,
                                        ),
                                        kHalfSizedBox,
                                        ListView.separated(
                                          itemCount: 10,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              kHalfSizedBox,
                                          itemBuilder: (context, index) =>
                                              VendorsProductContainer(
                                            onTap: _toProductDetailScreen,
                                          ),
                                        ),
                                        kSizedBox,
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                              color: kAccentColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        kSizedBox,
=======
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
                                            : VendorsProductsTab(
                                                list: Column(
                                                  children: [
                                                    CategoryButtonSection(
                                                      category:
                                                          _categoryButtonText,
                                                      categorybgColor:
                                                          _categoryButtonBgColor,
                                                      categoryFontColor:
                                                          _categoryButtonFontColor,
                                                    ),
                                                    kHalfSizedBox,
                                                    ListView.separated(
                                                      itemCount: 10,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              kHalfSizedBox,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          VendorsProductContainer(
                                                        onTap:
                                                            _toProductDetailScreen,
                                                      ),
                                                    ),
                                                    kSizedBox,
                                                    TextButton(
                                                      onPressed: _viewProducts,
                                                      child: Text(
                                                        "See all",
                                                        style: TextStyle(
                                                          color: kAccentColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    kSizedBox,
                                                  ],
                                                ),
                                              ),
                                        _loadingTabBarContent
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SpinKitChasingDots(
                                                      color: kAccentColor),
                                                ],
                                              )
                                            : VendorsAboutTab(
                                                list: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 0,
                                                      child: AboutVendor(
                                                        vendorName:
                                                            "Ntachi-Osa",
                                                        vendorHeadLine: "",
                                                        monToFriOpeningHours:
                                                            "",
                                                        monToFriClosingHours:
                                                            "",
                                                        satOpeningHours: "",
                                                        satClosingHours: "",
                                                        sunOpeningHours: "",
                                                        sunClosingHours: "",
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        "See all",
                                                        style: TextStyle(
                                                          color: kAccentColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    kSizedBox,
                                                  ],
                                                ),
                                              ),
>>>>>>> main:lib/app/vendor/vendor_details.dart
                                      ],
                                    ),
                                  ),
                            _loadingTabBarContent
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SpinKitChasingDots(color: kAccentColor),
                                    ],
                                  )
                                : VendorsAboutTab(
                                    list: Column(
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: AboutVendor(
                                            vendorName: "Ntachi-Osa",
                                            vendorHeadLine: "",
                                            monToFriOpeningHours: "",
                                            monToFriClosingHours: "",
                                            satOpeningHours: "",
                                            satClosingHours: "",
                                            sunOpeningHours: "",
                                            sunClosingHours: "",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                              color: kAccentColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        kSizedBox,
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
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
