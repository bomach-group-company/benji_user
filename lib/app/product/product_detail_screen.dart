import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../theme/colors.dart';
import 'report_product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  //=================================== ALL VARIABLES ==========================================\\

  int quantity = 1; // Add a variable to hold the quantity
  double price = 1200.0;
  final double itemPrice = 1200.0;

  //===================== STATES =======================\\
  @override
  void initState() {
    super.initState();
    _isAddedToFavorites = false;
    addedToCart = false;
  }

//===================== BOOL VALUES =======================\\
  var _isAddedToFavorites;
  var addedToCart;
  bool isLoading = false;

  //======================================= FUNCTIONS ==========================================\\
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

  Future<void> cartFunction() async {
    setState(() {
      addedToCart = !addedToCart;
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(Duration(seconds: 1));

    //Display snackBar
    mySnackBar(
      context,
      "Success!",
      addedToCart ? "Item has been added to cart." : "Item has been removed.",
      Duration(
        seconds: 1,
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  //======================================= Navigation ==========================================\\

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
            Get.to(
              () => ReportProduct(),
              routeName: 'ReportProduct',
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
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Container(
                  height: mediaHeight * 0.4,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/food/pasta.png",
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   top: mediaHeight * 0.25,
                //   left: mediaWidth / 5, // right: kDefaultPadding,
                //   right: mediaWidth / 5, // right: kDefaultPadding,
                //   child: Container(
                //     width: mediaWidth,
                //     height: 70,
                //     decoration: ShapeDecoration(
                //       color: Color(0xFFFAFAFA),
                //       shadows: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(
                //             0.1,
                //           ),
                //           blurRadius: 5,
                //           spreadRadius: 2,
                //           blurStyle: BlurStyle.normal,
                //         ),
                //       ],
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(
                //           19,
                //         ),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         IconButton(
                //           onPressed: () {
                //             decrementQuantity();
                //           },
                //           splashRadius: 10,
                //           icon: Icon(
                //             Icons.remove_rounded,
                //             color: kBlackColor,
                //           ),
                //         ),
                //         Container(
                //           height: 50,
                //           decoration: ShapeDecoration(
                //             color: Colors.white,
                //             shape: OvalBorder(),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(
                //               8.0,
                //             ),
                //             child: Center(
                //               child: Text(
                //                 '$quantity',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Color(
                //                     0xFF302F3C,
                //                   ),
                //                   fontSize: 31.98,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //         IconButton(
                //           onPressed: () {
                //             incrementQuantity();
                //           },
                //           splashRadius: 10,
                //           icon: Icon(
                //             Icons.add_rounded,
                //             color: kAccentColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //  Positioned(
                //   top: mediaHeight * 0.35,
                //   left: kDefaultPadding,
                //   right: kDefaultPadding,
                //   child: Container(
                //     height: mediaHeight - 220,
                //     width: mediaWidth,
                //     // color: kAccentColor,
                //     padding: EdgeInsets.all(
                //       5.0,
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Smokey Jollof Rice",
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: kTextBlackColor,
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //             ),
                //             Text(
                //               "₦ ${itemPrice.toStringAsFixed(2)}",
                //               style: TextStyle(
                //                 color: kTextBlackColor,
                //                 fontSize: 22,
                //                 fontFamily: 'sen',
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ),
                //           ],
                //         ),
                //         kSizedBox,
                //         Container(
                //           child: Text(
                //             "This is a short description about the food you mentoned which is a restaurant food in this case.",
                //             style: TextStyle(
                //               color: Color(
                //                 0xFF676565,
                //               ),
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //         kSizedBox,
                //         isLoading
                //             ? Column(
                //                 children: [
                //                   Center(
                //                     child: SpinKitChasingDots(
                //                       color: kAccentColor,
                //                       duration: const Duration(seconds: 1),
                //                     ),
                //                   ),
                //                   kSizedBox,
                //                 ],
                //               )
                //             : Center(
                //                 child: Container(
                //                   margin: EdgeInsets.only(
                //                     bottom: kDefaultPadding * 2,
                //                   ),
                //                   child: addedToCart
                //                       ? Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceAround,
                //                           children: [
                //                             ElevatedButton(
                //                               onPressed: () {
                //                                 cartFunction();
                //                               },
                //                               style: ElevatedButton.styleFrom(
                //                                 backgroundColor: kAccentColor,
                //                                 elevation: 20.0,
                //                                 shape: RoundedRectangleBorder(
                //                                   borderRadius:
                //                                       BorderRadius.circular(20),
                //                                 ),
                //                                 shadowColor: kBlackColor
                //                                     .withOpacity(0.4),
                //                                 minimumSize: Size(60, 60),
                //                                 maximumSize: Size(60, 60),
                //                               ),
                //                               child: Icon(
                //                                 Icons
                //                                     .remove_shopping_cart_rounded,
                //                                 color: kPrimaryColor,
                //                               ),
                //                             ),
                //                             ElevatedButton(
                //                               onPressed: () {
                //                                 Navigator.of(context).push(
                //                                   MaterialPageRoute(
                //                                     builder: (context) =>
                //                                         Cart(),
                //                                   ),
                //                                 );
                //                               },
                //                               style: ElevatedButton.styleFrom(
                //                                 backgroundColor: kAccentColor,
                //                                 elevation: 20.0,
                //                                 shape: RoundedRectangleBorder(
                //                                   borderRadius:
                //                                       BorderRadius.circular(20),
                //                                 ),
                //                                 shadowColor: kBlackColor
                //                                     .withOpacity(0.4),
                //                                 minimumSize: Size(
                //                                     MediaQuery.of(context)
                //                                             .size
                //                                             .width /
                //                                         1.5,
                //                                     60),
                //                                 maximumSize: Size(
                //                                     MediaQuery.of(context)
                //                                             .size
                //                                             .width /
                //                                         1.5,
                //                                     60),
                //                               ),
                //                               child: Text(
                //                                 "Go to cart".toUpperCase(),
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                   color: kPrimaryColor,
                //                                   fontSize: 18,
                //                                   fontWeight: FontWeight.w700,
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         )
                //                       : MyElevatedButton(
                //                           onPressed: () {
                //                             cartFunction();
                //                           },
                //                           title:
                //                               "Add to Cart (₦${price.toStringAsFixed(2)})",
                //                         ),
                //                 ),
                //               ),
                //         SizedBox(
                //           height: kDefaultPadding * 3,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
