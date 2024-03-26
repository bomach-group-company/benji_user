import 'package:benji/app/cart/my_cart.dart';
import 'package:benji/src/frontend/utils/constant.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  // Future<String> countCartFunc() async {
  //   String data = countCartItemTo10();
  //   return data;
  // }

  void _toCartScreen() async {
    await Get.to(
      () => const MyCarts(),
      routeName: 'MyCarts',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: _toCartScreen,
      child: Icon(Icons.shopping_cart,
          color: deviceType(mediaWidth) > 2 ? Colors.black : kAccentColor),
    );
  }
}
