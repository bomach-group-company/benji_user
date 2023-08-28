import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../app/cart/cart_screen.dart';
import '../../theme/colors.dart';
import '../repo/utils/cart.dart';

class CartCard extends StatefulWidget {
  final String? cartCount;
  const CartCard({super.key, this.cartCount});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  void initState() {
    super.initState();
    countCartFunc();
  }

  String? cartCount;

  countCartFunc() async {
    if (widget.cartCount == null) {
      String data = await countCart();
      setState(() {
        cartCount = data;
      });
    } else {
      setState(() {
        cartCount = cartCount;
      });
    }
  }

  void _toCartScreen() => Get.to(
        () => const CartScreen(),
        routeName: 'CartScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toCartScreen,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: _toCartScreen,
              splashRadius: 20,
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 28,
                color: kAccentColor,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              height: 20,
              width: 20,
              decoration: ShapeDecoration(
                color: kAccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Center(
                child: Text(
                  cartCount == null ? '0' : cartCount!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
