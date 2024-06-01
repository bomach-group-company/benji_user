import 'package:benji/app/cart/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../theme/colors.dart';
import '../../repo/controller/cart_controller.dart';

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
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.cartPlus,
              color: kAccentColor,
              size: 24,
            ),
          ),
          Positioned(
            top: 4,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: kAccentColor,
                shape: const OvalBorder(),
              ),
              child: GetBuilder<CartController>(builder: (controller) {
                return Text(
                  "${controller.countCartAll.value}",
                  style: const TextStyle(color: kTextWhiteColor),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
