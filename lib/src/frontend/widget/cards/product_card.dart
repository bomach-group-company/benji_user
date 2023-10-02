import 'package:benji_user/src/frontend/model/product.dart';
import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:benji_user/src/repo/utils/user_cart.dart';
import 'package:flutter/material.dart';

import '../clickable.dart';

class MyCard extends StatefulWidget {
  final Product product;
  final Widget? navigate;
  final Function()? action;
  final Widget? navigateCategory;

  const MyCard({
    super.key,
    required this.product,
    this.navigate,
    this.action,
    this.navigateCategory,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  void initState() {
    super.initState();
    _cartCount();
  }

  Future<void> _cartAddFunction() async {
    await addToCart(
        widget.product.vendor.id!.toString(), widget.product.id.toString());
    await _cartCount();
  }

  Future<void> _cartRemoveFunction() async {
    await removeFromCart(
        widget.product.vendor.id!.toString(), widget.product.id.toString());
    await _cartCount();
  }

  bool addedToCart = false;
  _cartCount() async {
    int count = await countCartItemByProduct(
        widget.product.vendor.id!.toString(), widget.product.id.toString());
    setState(() {
      addedToCart = count > 0;
    });
  }

  double blurRadius = 2;
  double margin = 15;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          blurRadius = 20;
          margin = 10;
        });
      },
      onExit: (event) {
        setState(() {
          blurRadius = 2;
          margin = 15;
        });
      },
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        margin: EdgeInsets.all(margin),
        duration: const Duration(microseconds: 200000),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: const Border.fromBorderSide(
            BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: blurRadius,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.action,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.product.productImage!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(
                            'assets/frontend/assets/product_asset/veg.png',
                          ),
                        ),
                        kHalfWidthSizedBox,
                        Expanded(
                          child: MyClickable(
                            navigate: widget.navigate,
                            child: Text(
                              widget.product.name,
                              softWrap: false,
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyClickable(
                          navigate: widget.navigateCategory,
                          child: Text(
                            widget.product.subCategory.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: kGreenColor,
                                fontSize: 13,
                                height: 2),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${widget.product.price}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        addedToCart
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: kGreenColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                ),
                                onPressed: _cartRemoveFunction,
                                child: const Text('REMOVE'),
                              )
                            : OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: kGreenColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                ),
                                onPressed: _cartAddFunction,
                                child: const Text('ADD'),
                              ),
                      ],
                    ),
                    kHalfSizedBox
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
