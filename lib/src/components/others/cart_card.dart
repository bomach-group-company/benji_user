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
    );
  }
}
