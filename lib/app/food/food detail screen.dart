import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/providers/constants.dart';
import '../../src/reusable widgets/category button section.dart';
import '../../src/reusable widgets/my elevatedbutton.dart';
import '../../src/reusable widgets/my fixed snackBar.dart';
import '../../src/reusable widgets/my floating snackbar.dart';
import '../../theme/colors.dart';
import '../cart/cart.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  //=================================== ALL VARIABLES ==========================================\\

  int quantity = 1; // Add a variable to hold the quantity
  double price = 1200.0;
  final double itemPrice = 1200.0;

  //===================== STATES =======================\\
  @override
  void initState() {
    super.initState();
    addedFavorite = false;
    addedToCart = false;
  }

//===================== BOOL VALUES =======================\\
  var addedFavorite;
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

  void favorite() {
    setState(() {
      addedFavorite = !addedFavorite;
    });

    myFixedSnackBar(
      context,
      addedFavorite
          ? "Added to Favorites".toUpperCase()
          : "Removed from Favorites".toUpperCase(),
      kAccentColor,
      Duration(
        seconds: 1,
      ),
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

  //===================== CATEGORY BUTTONS =======================\\
  final List _proteinCategoryButtonText = [
    "Beef (+N2,000)",
    "Goat meat (+N700)",
    "Fish (+N700)",
    "Chicken (+N2,500)",
    "Pork (+N800)",
  ];

  final List<Color> _proteinCategoryButtonBgColor = [
    kAccentColor,
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    )
  ];
  final List<Color> _proteincategoryButtonFontColor = [
    kPrimaryColor,
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    )
  ];
  final List _stewTypeCategoryButtonText = [
    "Tomato (+N250)",
    "Ofe Akwu (+N0)",
    "Chicken Sauce  (+N4000)",
    "Egg Sauce(+N2,500)",
    "Curry Sauce (+N2,000)",
  ];

  final List<Color> _stewTypeCategoryButtonBgColor = [
    kAccentColor,
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
  ];
  final List<Color> _stewTypeCategoryButtonFontColor = [
    kPrimaryColor,
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white.withOpacity(
          0.6,
        ),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: mediaHeight * 0.3,
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
            ),
            Positioned(
              top: mediaHeight * 0.04,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                width: mediaWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(
                            0xFFFAFAFA,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              19,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        favorite();
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(
                            0xFFFAFAFA,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              19,
                            ),
                          ),
                        ),
                        child: Icon(
                          addedFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: kAccentColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: mediaHeight * 0.35,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                height: mediaHeight - 220,
                width: mediaWidth,
                // color: kAccentColor,
                padding: EdgeInsets.all(
                  5.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Smokey Jollof Rice",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(
                                0xFF302F3C,
                              ),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "₦ ${itemPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Color(
                                0xFF333333,
                              ),
                              fontSize: 22,
                              fontFamily: 'sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      Container(
                        child: Text(
                          "This is a short description about the food you mentoned which is a restaurant food in this case.",
                          style: TextStyle(
                            color: Color(
                              0xFF676565,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: kDefaultPadding,
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "Protein",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(
                              0xFF302F3C,
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      CategoryButtonSection(
                        category: _proteinCategoryButtonText,
                        categorybgColor: _proteinCategoryButtonBgColor,
                        categoryFontColor: _proteincategoryButtonFontColor,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: kDefaultPadding,
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "Stew Type",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(
                              0xFF302F3C,
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      CategoryButtonSection(
                        category: _stewTypeCategoryButtonText,
                        categorybgColor: _stewTypeCategoryButtonBgColor,
                        categoryFontColor: _stewTypeCategoryButtonFontColor,
                      ),
                      kSizedBox,
                      isLoading
                          ? Column(
                              children: [
                                Center(
                                  child: SpinKitChasingDots(
                                    color: kAccentColor,
                                    duration: const Duration(seconds: 1),
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
                                child: addedToCart
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              cartFunction();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kAccentColor,
                                              elevation: 20.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              shadowColor:
                                                  kBlackColor.withOpacity(0.4),
                                              minimumSize: Size(60, 60),
                                              maximumSize: Size(60, 60),
                                            ),
                                            child: Icon(
                                              Icons
                                                  .remove_shopping_cart_rounded,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => Cart(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kAccentColor,
                                              elevation: 20.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              shadowColor:
                                                  kBlackColor.withOpacity(0.4),
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  60),
                                              maximumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  60),
                                            ),
                                            child: Text(
                                              "Go to cart".toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : MyElevatedButton(
                                        onPressed: () {
                                          cartFunction();
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
              ),
            ),
            Positioned(
              top: mediaHeight * 0.25,
              left: mediaWidth / 5, // right: kDefaultPadding,
              right: mediaWidth / 5, // right: kDefaultPadding,
              child: Container(
                width: mediaWidth,
                height: 70,
                decoration: ShapeDecoration(
                  color: Color(
                    0xFFFAFAFA,
                  ),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ),
                      blurRadius: 5,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      19,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        decrementQuantity();
                      },
                      splashRadius: 10,
                      icon: Icon(
                        Icons.remove_rounded,
                        color: kBlackColor,
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: Center(
                          child: Text(
                            '$quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(
                                0xFF302F3C,
                              ),
                              fontSize: 31.98,
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
                      splashRadius: 10,
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
    );
  }
}
