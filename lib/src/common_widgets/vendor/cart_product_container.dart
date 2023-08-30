import 'package:benji_user/src/repo/utils/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../repo/models/product/product.dart';
import '../snackbar/my_floating_snackbar.dart';

class ProductCartContainer extends StatefulWidget {
  final Function() onTap;
  final Function()? incrementQuantity;
  final Function()? decrementQuantity;
  final Product product;
  const ProductCartContainer({
    super.key,
    required this.onTap,
    this.incrementQuantity,
    this.decrementQuantity,
    required this.product,
  });

  @override
  State<ProductCartContainer> createState() => sProductContaCartinerState();
}

class sProductContaCartinerState extends State<ProductCartContainer> {
  @override
  void initState() {
    super.initState();
    checkCart();
    _productPrice = widget.product.price;
  }
  //======================================= VARIABLES ==========================================\\

  double _productPrice = 0;
  String cartCount = '1';
  String cartCountAll = '1';

//===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

//===================== Cart logic functions ==========================\\

  checkCart() async {
    String count = await countCart();
    String countAll = await countCart(all: true);

    setState(() {
      cartCount = count;
      cartCountAll = countAll;
    });
    if (cartCountAll == '0') {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Item has been removed from cart.",
        Duration(
          seconds: 1,
        ),
      );
    }
  }

  // void incrementQuantity() async {
  //   await addToCart(widget.product.id);
  //   await checkCart();
  // }

  // void decrementQuantity() async {
  //   await removeFromCart(widget.product.id);
  //   await checkCart();
  // }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    // double mediaHeight = MediaQuery.of(context).size.height;

    return cartCountAll == '0'
        ? SizedBox()
        : InkWell(
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
                    width: 120,
                    height: 120,
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
                        width: mediaWidth - 200,
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        width: mediaWidth - 200,
                        child: Text(
                          widget.product.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kSizedBox,
                      Row(
                        children: [
                          SizedBox(
                            width: (mediaWidth - 200) / 2,
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
                            width: (mediaWidth - 200) / 2,
                            child: Text(
                              "Qty: ${formattedText(double.parse(cartCountAll))}",
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
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (widget.decrementQuantity != null) {
                            widget.decrementQuantity!();
                          }
                          checkCart();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.circleMinus,
                          color: kAccentColor,
                        ),
                      ),
                      Text(
                        "$cartCountAll",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (widget.incrementQuantity != null) {
                            widget.incrementQuantity!();
                          }
                          checkCart();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.circlePlus,
                          color: kAccentColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
