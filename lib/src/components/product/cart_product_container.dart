// ignore_for_file: use_build_context_synchronously

import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
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
  State<ProductCartContainer> createState() => ProductCartContainerState();
}

class ProductCartContainerState extends State<ProductCartContainer> {
  @override
  void initState() {
    super.initState();
    checkCart();
    _productPrice = widget.product.price;
  }
  //======================================= VARIABLES ==========================================\\

  double _productPrice = 0;
  String cartCountAll = '1';

//===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

//===================== Cart logic functions ==========================\\

  checkCart() async {
    int countAll = countCartItemByProduct(widget.product);

    setState(() {
      cartCountAll = countAll.toString();
    });
    if (cartCountAll == '0') {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Item has been removed from cart.",
        const Duration(
          seconds: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return cartCountAll == '0'
        ? const SizedBox()
        : InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: ShapeDecoration(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19616161),
                    blurRadius: 24,
                    offset: Offset(0, 0),
                    spreadRadius: 7,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 186,
                    decoration: ShapeDecoration(
                      color: kPageSkeletonColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.20),
                          topRight: Radius.circular(7.20),
                        ),
                      ),
                      // image: DecorationImage(
                      //   image:
                      //       AssetImage("assets/images/products/okra-soup.png"),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    child: Center(
                        child: MyImage(
                      url: widget.product.productImage,
                      radiusBottom: 0,
                      radiusTop: 7.5,
                    )),
                  ),
                  kSizedBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              widget.product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          SizedBox(
                            child: Text(
                              widget.product.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.43,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  "₦${formattedText(_productPrice)}",
                                  style: const TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 20,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Row(
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
                                    cartCountAll,
                                    style: const TextStyle(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                ],
              ),
            ),
          );
  }
}
