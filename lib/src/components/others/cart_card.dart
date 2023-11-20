import 'package:benji/app/cart/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../theme/colors.dart';

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
  }

  // Future<String> countCartFunc() async {
  //   String data = countCartItemTo10();
  //   if (widget.cartCount == null) {
  //     return data;
  //   } else {
  //     return widget.cartCount!;
  //   }
  // }

  void _toCartScreen() async {
    await Get.to(
      () => const MyCarts(),
      routeName: 'MyCarts',
      duration: const Duration(milliseconds: 1000),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.cupertinoDialog,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toCartScreen,
      child: Container(
        alignment: Alignment.center,
        child: FaIcon(
          FontAwesomeIcons.cartPlus,
          color: kAccentColor,
          size: 24,
        ),
      ),
      // child: Stack(
      // children: [
      // Container(
      //   alignment: Alignment.center,
      //   child: IconButton(
      //     onPressed: _toCartScreen,
      //     splashRadius: 20,
      //     icon: Icon(
      //       Icons.shopping_cart,
      //       size: 30,
      //       color: kAccentColor,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   top: 5,
      //   right: 5,
      //   child: Container(
      //     height: 20,
      //     width: 20,
      //     decoration: ShapeDecoration(
      //       color: kAccentColor,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(100),
      //       ),
      //     ),
      //     child: Center(
      //       child: FutureBuilder(
      //           future: countCartFunc(),
      //           builder: (context, snapshot) {
      //             if (!snapshot.hasData) {
      //               return const Text('');
      //             }
      //             return Text(
      //               snapshot.data!,
      //               textAlign: TextAlign.center,
      //               style: const TextStyle(
      //                 fontSize: 9,
      //                 fontWeight: FontWeight.w400,
      //               ),
      //             );
      //           }),
      //     ),
      //   ),
      // ),
      // ],
      // ),
    );
  }
}
