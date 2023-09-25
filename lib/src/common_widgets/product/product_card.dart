import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/constants.dart';

class ProductCard extends StatelessWidget {
  final Function()? onTap;
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

//===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.19),
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
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/products/okra-soup.png"),
                  fit: BoxFit.fill,
                ),
              ),
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
                        product.name,
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
                        product.vendorId.shopName!,
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.43,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kSizedBox,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                child: Text(
                  '₦${formattedText(product.price)}',
                  style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 20,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
