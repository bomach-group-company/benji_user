import 'package:benji_user/src/frontend/model/product.dart';
import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:benji_user/src/repo/utils/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../clickable.dart';

class MyCardLg extends StatefulWidget {
  final Product product;
  final Widget? navigate;
  final Function()? close;
  final Widget? navigateCategory;
  final bool visible;

  const MyCardLg({
    super.key,
    this.visible = false,
    required this.product,
    this.close,
    this.navigate,
    // const ProductPage(id: '2f8f8557-e313-465c-979f-c42f4b7e36dd'),
    this.navigateCategory,
  });

  @override
  State<MyCardLg> createState() => _MyCardLgState();
}

class _MyCardLgState extends State<MyCardLg> {
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
    final media = MediaQuery.of(context).size;

    return MouseRegion(
      // onEnter: (event) {
      //   setState(() {
      //     blurRadius = 20;
      //     margin = 10;
      //   });
      // },
      // onExit: (event) {
      //   setState(() {
      //     blurRadius = 2;
      //     margin = 15;
      //   });
      // },
      child: Visibility(
        visible: widget.visible,
        child: GestureDetector(
          onTap: widget.close,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.4),
            child: GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 800,
                      maxHeight: breakPoint(media.width, 500, 400, 400),
                    ),
                    margin: EdgeInsets.all(margin),
                    padding: EdgeInsets.symmetric(
                        vertical: breakPoint(media.width, 25, 50, 50),
                        horizontal: breakPoint(media.width, 25, 50, 50)),
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
                    child: LayoutGrid(
                      columnSizes: breakPointDynamic(
                          media.width, [1.fr], [1.fr, 1.fr], [1.fr, 1.fr]),
                      rowSizes: breakPointDynamic(
                          media.width, [1.fr, 1.fr], [auto], [auto]),
                      children: [
                        MyClickable(
                          navigate: widget.navigate,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(widget.product.productImage!),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: breakPoint(media.width, 0, 25, 25),
                            top: breakPoint(media.width, 25, 0, 0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              kHalfSizedBox,
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                widget.product.description,
                                maxLines: 9,
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 30,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: widget.close,
                        child: const Text(
                          'close',
                          style: TextStyle(
                            color: kGreenColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
