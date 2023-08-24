import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../snackbar/my_floating_snackbar.dart';

class VendorFoodContainer extends StatefulWidget {
  final Function() onTap;
  const VendorFoodContainer({
    super.key,
    required this.onTap,
  });

  @override
  State<VendorFoodContainer> createState() => _VendorFoodContainerState();
}

class _VendorFoodContainerState extends State<VendorFoodContainer> {
  //======================================= ALL VARIABLES ==========================================\\

  int _quantity = 1;
  double _productPrice = 1200;

  //======================================= BOOL VALUES ==========================================\\
  bool isAddedToCart = false;

  //======================================= FUNCTIONS ==========================================\\

  void incrementQuantity() {
    setState(() {
      _quantity++; // Increment the quantity by 1
    });
  }

  void decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--; // Decrement the quantity by 1, but ensure it doesn't go below 1
      } else {
        cartFunction();
      }
    });
  }

  void cartFunction() {
    setState(() {
      isAddedToCart = !isAddedToCart;
    });

    mySnackBar(
      context,
      "Success!",
      isAddedToCart ? "Item has been added to cart." : "Item has been removed.",
      Duration(
        seconds: 1,
      ),
    );
  }

//===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    // double mediaHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: mediaWidth,
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 24,
                offset: Offset(0, 4),
                spreadRadius: 0)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 92,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/products/pasta.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            kHalfWidthSizedBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: mediaWidth / 2,
                  child: Text(
                    'Smokey Jollof Pasta',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                kHalfSizedBox,
                Container(
                  width: mediaWidth / 2,
                  child: Text(
                    'Short description about the food here',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                kHalfSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: mediaWidth / 4,
                      child: Text(
                        "₦${formattedText(_productPrice)}",
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 14,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mediaWidth / 4,
                      height: 17,
                      child: Text(
                        "Qty: ${formattedText(200)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isAddedToCart
                ? Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          decrementQuantity();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.circleMinus,
                          color: kAccentColor,
                        ),
                      ),
                      Text(
                        "$_quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          incrementQuantity();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.circlePlus,
                          color: kAccentColor,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      cartFunction();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.circlePlus,
                      color: kAccentColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
