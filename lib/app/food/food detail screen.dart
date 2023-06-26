import 'package:alpha_logistics/modules/category%20button%20section.dart';
import 'package:alpha_logistics/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../reusable widgets/my elevatedbutton.dart';
import '../../theme/constants.dart';
import '../cart/cart.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  //===================================================\\

  //===================== ALL VARIABLES =======================\\

  int quantity = 1; // Add a variable to hold the quantity

  void incrementQuantity() {
    setState(() {
      quantity++; // Increment the quantity by 1
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--; // Decrement the quantity by 1, but ensure it doesn't go below 1
      }
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
    ),
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
    ),
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
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white.withOpacity(
          0.6,
        ),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 320,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                  ),
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
              top: 60,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Container(
                        width: 56,
                        height: 56,
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
                          Icons.arrow_back_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 56,
                        height: 56,
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
                          Icons.favorite_border_rounded,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 380,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // color: kAccentColor,
                padding: EdgeInsets.all(
                  5.0,
                ),
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
                          "₦ 850",
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
                    SizedBox(
                      height: kDefaultPadding * 2,
                    ),
                    Center(
                      child: Container(
                        child: MyElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                          title: "Add to Cart (N20,000)",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 285,
              left: MediaQuery.of(context).size.width /
                  2.9, // right: kDefaultPadding,
              child: Container(
                width: 158,
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
                      width: 56,
                      height: 56,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
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
