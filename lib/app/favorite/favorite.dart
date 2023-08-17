// ignore_for_file: unused_local_variable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/common_widgets/category_button_section_tab.dart';
import '../../src/common_widgets/custom showSearch.dart';
import '../../src/common_widgets/home popular vendors card.dart';
import '../../src/common_widgets/my appbar.dart';
import '../../src/common_widgets/vendors food container.dart';
import '../../src/common_widgets/vendors_order_container.dart';
import '../../src/common_widgets/vendors_product_container.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../cart/cart.dart';
import '../food/food detail screen.dart';
import 'favorite_products.dart';
import 'favorite_vendors.dart';

class Favorite extends StatefulWidget {
  final String vendorCoverImage;
  final String vendorName;
  final double vendorRating;
  final String vendorActiveStatus;
  final Color vendorActiveStatusColor;
  const Favorite({
    super.key,
    required this.vendorCoverImage,
    required this.vendorName,
    required this.vendorRating,
    required this.vendorActiveStatus,
    required this.vendorActiveStatusColor,
  });

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite>
    with SingleTickerProviderStateMixin {
  //=================================== ALL VARIABLES ====================================\\
  //======================================================================================\\
  @override
  void initState() {
    super.initState();

    _tabBarController = TabController(length: 2, vsync: this);
    _loadingScreen = false;
    // _loadingScreen = true;
    // Future.delayed(
    //   const Duration(seconds: 0),
    //   () => setState(
    //     () => _loadingScreen = false,
    //   ),
    // );
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
  final int _incrementOrderID = 2 + 2;
  late int _orderID;
  final String _orderItem = "Jollof Rice and Chicken";
  final String _customerAddress = "21 Odogwu Street, New Haven";
  final int _itemQuantity = 2;
  // final double _price = 2500;
  final double _itemPrice = 2500;
  final String _orderImage = "chizzy's-food";
  final String _customerName = "Mercy Luke";

  //=============================== Products ====================================\\
  final String _productName = "Smokey Jollof Pasta";
  final String _productImage = "pasta";
  final String _productDescription =
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos  sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis  minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit  quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur  fugiat, temporibus enim commodi iusto libero magni deleniti quod quam consequuntur! Commodi minima excepturi repudiandae velit hic maxime doloremque. Quaerat provident commodi consectetur veniam similique ad earum omnis ipsum saepe, voluptas, hic voluptates pariatur est explicabo fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam totam ratione voluptas quod exercitationem fuga. Possim";
  final double _productPrice = 1200;

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

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

//===================== VENDORS LIST VIEW INDEX =======================\\
  List<int> foodListView = [0, 1, 3, 4, 5, 6];

//===================== FUNCTIONS =======================\\
  double calculateSubtotal() {
    return _itemPrice * _itemQuantity;
  }

  void _changeProductCategory() {}

//===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    // setState(() {
    //   _loadingScreen = true;
    // });
    // await Future.delayed(const Duration(seconds: 3));
    // setState(() {
    //   _loadingScreen = false;
    // });
  }

  void _clickOnTabBarOption() async {
    setState(() {
      _loadingTabBarContent = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _loadingTabBarContent = false;
    });
  }

  //=================================== Show Popup Menu =====================================\\
  //Show popup menu
  void showPopupMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    const position = RelativeRect.fromLTRB(10, 60, 0, 0);

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        const PopupMenuItem<String>(
          value: 'visit',
          child: Text("Visit vendor"),
        ),
        const PopupMenuItem<String>(
          value: 'suspend',
          child: Text("Suspend vendor"),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'more':
            () {};
            break;
          case 'suspend':
            () {};
            break;
        }
      }
    });
  }

  //===================== Navigation ==========================\\
  void toProductDetailScreen() {}

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    double subtotalPrice = calculateSubtotal();

//====================================================================================\\

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.of(context).pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: const Color(
                          0xFFFEF8F8,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(
                              0xFFFDEDED,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            24,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        titleSpacing: kDefaultPadding / 2,
        elevation: 0.0,
        title: Text(
          "Favorite",
          style: const TextStyle(
            color: Color(
              0xFF151515,
            ),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.40,
          ),
        ),
        // toolbarHeight: 40,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ),
                  );
                },
                splashRadius: 20,
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: kAccentColor,
                ),
              ),
              Positioned(
                top: 2,
                right: 10,
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
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: FutureBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(child: SpinKitDoubleBounce(color: kAccentColor));
          }
          if (snapshot.connectionState == ConnectionState.none) {
            const Center(
              child: Text("Please connect to the internet"),
            );
          }
          // if (snapshot.connectionState == snapshot.requireData) {
          //   SpinKitDoubleBounce(color: kAccentColor);
          // }
          if (snapshot.connectionState == snapshot.error) {
            const Center(
              child: Text("Error, Please try again later"),
            );
          }
          return _loadingScreen
              ? Center(child: SpinKitDoubleBounce(color: kAccentColor))
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
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
                                    Tab(text: "Orders"),
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
                        height: mediaHeight + mediaHeight + mediaHeight,
                        width: mediaWidth,
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(
                                controller: _tabBarController,
                                physics: const BouncingScrollPhysics(),
                                dragStartBehavior: DragStartBehavior.down,
                                children: [
                                  _loadingTabBarContent
                                      ? const Center(
                                          child: Text('Loading'),
                                        )
                                      : VendorsProductsTab(
                                          list: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CategoryButtonSection(
                                                onPressed:
                                                    _changeProductCategory,
                                                category: _categoryButtonText,
                                                categorybgColor:
                                                    _categoryButtonBgColor,
                                                categoryFontColor:
                                                    _categoryButtonFontColor,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical:
                                                          kDefaultPadding * 0.5,
                                                    ),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Pasta',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF333333),
                                                        fontSize: 18,
                                                        fontFamily: 'Sen',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int i = 0;
                                                  i < foodListView.length;
                                                  i++)
                                                VendorFoodContainer(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FoodDetailScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                  _loadingTabBarContent
                                      ? const Center(
                                          child: Text('Loading...'),
                                        )
                                      : VendorsOrdersTab(
                                          list: Column(
                                            children: [
                                              for (_orderID = 1;
                                                  _orderID < 30;
                                                  _orderID += _incrementOrderID)
                                                PopularVendorsCard(
                                                  onTap: () {},
                                                  cardImage:
                                                      'best-choice-restaurant.png',
                                                  bannerColor: kAccentColor,
                                                  bannerText: "Free Delivery",
                                                  vendorName:
                                                      "Best Choice restaurant",
                                                  food: "Food",
                                                  category: "Fast Food",
                                                  rating: "3.6",
                                                  noOfUsersRated: "500",
                                                ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
