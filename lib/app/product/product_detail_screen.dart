import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:readmore/readmore.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../theme/colors.dart';
import '../cart/cart_screen.dart';
import 'report_product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  //==================================================== INITIAL STATE ======================================================\\
  @override
  void initState() {
    super.initState();
    _isAddedToFavorites = false;
    _isAddedToCart = false;
    _loadingScreen = true;

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }
  //============================================================ ALL VARIABLES ===================================================================\\

  int quantity = 1; // Add a variable to hold the quantity
  double price = 1200.0;
  final double itemPrice = 1200.0;

//====================================================== BOOL VALUES ========================================================\\
  late bool _loadingScreen;
  var _isAddedToFavorites;
  var _isAddedToCart;
  bool isLoading = false;

  //==================================================== CONTROLLERS ======================================================\\
  ScrollController _scrollController = ScrollController();

  //======================================================= FUNCTIONS ==========================================================\\
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
  void incrementQuantity() {
    setState(() {
      quantity++; // Increment the quantity by 1
      price = quantity * itemPrice;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--; // Decrement the quantity by 1, but ensure it doesn't go below 1
        price = quantity * itemPrice;
      }
    });
  }

  void _addToFavorites() {
    setState(() {
      _isAddedToFavorites = !_isAddedToFavorites;
    });

    mySnackBar(
      context,
      "Success",
      _isAddedToFavorites
          ? "Product has been added to favorites"
          : "Product been removed from favorites",
      Duration(milliseconds: 500),
    );
  }

  Future<void> _cartFunction() async {
    setState(() {
      _isAddedToCart = !_isAddedToCart;
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(Duration(seconds: 1));

    //Display snackBar
    mySnackBar(
      context,
      "Success!",
      _isAddedToCart
          ? "Item has been added to cart."
          : "Item has been removed.",
      Duration(
        seconds: 1,
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  //======================================= Navigation ==========================================\\
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

  void _toReportProduct() => Get.to(
        () => ReportProduct(),
        routeName: 'ReportProduct',
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
    const position = RelativeRect.fromLTRB(10, 60, 0, 0);

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        const PopupMenuItem<String>(
          value: 'report',
          child: Text("Report product"),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'report':
            _toReportProduct;
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Product Detail",
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: _addToFavorites,
              icon: FaIcon(
                _isAddedToFavorites
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: kAccentColor,
              ),
            ),
            _isAddedToCart
                ? IconButton(
                    onPressed: _toCartScreen,
                    icon: FaIcon(
                      FontAwesomeIcons.cartShopping,
                      color: kAccentColor,
                    ),
                  )
                : SizedBox(),
            IconButton(
              onPressed: () => showPopupMenu(context),
              icon: FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: kAccentColor,
              ),
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
                    : Scrollbar(
                        controller: _scrollController,
                        radius: const Radius.circular(10),
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          children: [
                            SizedBox(
                              height: mediaHeight * 0.46,
                              child: Stack(
                                children: [
                                  Container(
                                    height: mediaHeight * 0.4,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/images/products/pasta.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: mediaHeight * 0.35,
                                    left: mediaWidth /
                                        5, // right: kDefaultPadding,
                                    right: mediaWidth /
                                        5, // right: kDefaultPadding,
                                    child: Container(
                                      width: mediaWidth,
                                      height: 70,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFFAFAFA),
                                        shadows: [
                                          BoxShadow(
                                            color: kBlackColor.withOpacity(0.1),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.normal,
                                          ),
                                        ],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              decrementQuantity();
                                            },
                                            splashRadius: 50,
                                            icon: Icon(
                                              Icons.remove_rounded,
                                              color: kBlackColor,
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            decoration: ShapeDecoration(
                                              color: kAccentColor,
                                              shape: OvalBorder(),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          kDefaultPadding / 2),
                                              child: Center(
                                                child: Text(
                                                  '$quantity',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: kTextWhiteColor,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              incrementQuantity();
                                            },
                                            splashRadius: 50,
                                            icon: Icon(
                                              Icons.add_rounded,
                                              color: kAccentColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: mediaWidth,
                              padding: EdgeInsets.all(kDefaultPadding / 2),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Smokey Jollof Rice",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "₦ ${itemPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 22,
                                          fontFamily: 'sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kSizedBox,
                                  Container(
                                    child: ReadMoreText(
                                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur fugiat, temporibus enim commodi iusto libero magni deleniti quod quam consequuntur! Commodi minima excepturi repudiandae velit hic maxime doloremque. Quaerat provident commodi consectetur veniam similique ad earum omnis ipsum saepe, voluptas, hic voluptates pariatur est explicabo fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam totam ratione voluptas quod exercitationem fuga. Possimus quis earum veniam quasi aliquam eligendi, placeat qui corporis! ",
                                      callback: (value) {},
                                      colorClickableText: kAccentColor,
                                      moreStyle: TextStyle(color: kAccentColor),
                                      lessStyle: TextStyle(color: kAccentColor),
                                      delimiter: "...",
                                      delimiterStyle:
                                          TextStyle(color: kAccentColor),
                                      trimMode: TrimMode.Line,
                                      trimLines: 4,
                                    ),

                                    //  Text(
                                    //   "This is a short description about the food you mentoned which is a restaurant food in this case.",
                                    //   style: TextStyle(
                                    //     color: kTextGreyColor,
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    // ),
                                  ),
                                  kSizedBox,
                                  isLoading
                                      ? Column(
                                          children: [
                                            Center(
                                              child: SpinKitChasingDots(
                                                color: kAccentColor,
                                                duration:
                                                    const Duration(seconds: 1),
                                              ),
                                            ),
                                            kSizedBox,
                                          ],
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: kDefaultPadding * 2,
                                            ),
                                            child: _isAddedToCart
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _cartFunction();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              kAccentColor,
                                                          elevation: 20.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          shadowColor:
                                                              kBlackColor
                                                                  .withOpacity(
                                                                      0.4),
                                                          minimumSize:
                                                              Size(60, 60),
                                                          maximumSize:
                                                              Size(60, 60),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .remove_shopping_cart_rounded,
                                                          color: kPrimaryColor,
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CartScreen(),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              kAccentColor,
                                                          elevation: 20.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          shadowColor:
                                                              kBlackColor
                                                                  .withOpacity(
                                                                      0.4),
                                                          minimumSize: Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.5,
                                                              60),
                                                          maximumSize: Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.5,
                                                              60),
                                                        ),
                                                        child: Text(
                                                          "Go to cart"
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : MyElevatedButton(
                                                    onPressed: () {
                                                      _cartFunction();
                                                    },
                                                    title:
                                                        "Add to Cart (₦${price.toStringAsFixed(2)})",
                                                  ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: kDefaultPadding * 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
