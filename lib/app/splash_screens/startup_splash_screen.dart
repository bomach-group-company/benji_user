// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/controller/auth_controller.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/controller/category_controller.dart';
import 'package:benji/src/repo/controller/favourite_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/package_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class StartupSplashscreen extends StatefulWidget {
  const StartupSplashscreen({super.key});

  @override
  State<StartupSplashscreen> createState() => _StartupSplashscreenState();
}

class _StartupSplashscreenState extends State<StartupSplashscreen> {
  @override
  void initState() {
    if (UserController.instance.isUSer()) {
      ProductController.instance.getProduct();
      VendorController.instance.getVendors();
      VendorController.instance.getPopularVendors(start: 0, end: 4);
      CategoryController.instance.getCategory();
      AddressController.instance.getAdresses();
      AddressController.instance.getCurrentAddress();
      OrderController.instance.getOrders();
      CartController.instance.getCartProduct();
      FavouriteController.instance.getProduct();
      FavouriteController.instance.getVendor();
      MyPackageController.instance.getDeliveryItemsByPending();
      MyPackageController.instance.getDeliveryItemsByDelivered();
    }
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        AuthController.instance.checkAuth();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          SizedBox(
            height: media.height,
            width: media.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: media.height / 4,
                  width: media.width / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/splash_screen/frame_1.png"),
                    ),
                  ),
                ),
                kSizedBox,
                SpinKitThreeInOut(
                  color: kSecondaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
