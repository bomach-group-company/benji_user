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
import 'package:benji/src/repo/controller/shopping_location_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/fcm_messaging_controller.dart';
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
      isAuthorized().then((value) async {
        if (value) {
          await FcmMessagingController.instance.handleFCM();
          await ProductController.instance.getProduct();
          await ProductController.instance.getTopProducts();
          await VendorController.instance.getVendors();
          await VendorController.instance
              .getPopularBusinesses(start: 0, end: 4);
          await CategoryController.instance.getCategory();
          await AddressController.instance.getAdresses();
          await AddressController.instance.getCurrentAddress();
          await OrderController.instance.getOrders();
          await CartController.instance.getCartProduct();
          await FavouriteController.instance.getProduct();
          await FavouriteController.instance.getVendor();
          await MyPackageController.instance.getDeliveryItemsByPending();
          await MyPackageController.instance.getDeliveryItemsByDelivered();
          await ShoppingLocationController.instance
              .getShoppingLocationCountries();
        }
      });
    }
    Timer(
      const Duration(seconds: 2),
      () {
        AuthController.instance.checkAuth();
      },
    );
    super.initState();
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
