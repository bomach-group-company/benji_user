import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../repo/models/product/product.dart';

class ProductContainer extends StatefulWidget {
  final Function() onTap;
  final Product product;
  const ProductContainer({
    super.key,
    required this.onTap,
    required this.product,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  void initState() {
    super.initState();
    _productPrice = widget.product.price;
  }
  //======================================= VARIABLES ==========================================\\

  double _productPrice = 0;

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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
