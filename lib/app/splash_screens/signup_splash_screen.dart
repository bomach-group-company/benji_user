// ignore_for_file: camel_case_types, file_names

import 'dart:async';

import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/controller/category_controller.dart';
import 'package:benji/src/repo/controller/favourite_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/package_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../src/repo/controller/fcm_messaging_controller.dart';
import '../../theme/colors.dart';
import '../home/home.dart';

class SignUpSplashScreen extends StatefulWidget {
  const SignUpSplashScreen({super.key});

  @override
  State<SignUpSplashScreen> createState() => _SignUpSplashScreenState();
}

class _SignUpSplashScreenState extends State<SignUpSplashScreen> {
  @override
  void initState() {
    if (UserController.instance.isUSer()) {
      FcmMessagingController.instance.handleFCM();

      ProductController.instance.getProduct();
      VendorController.instance.getVendors();
      VendorController.instance.getPopularBusinesses(start: 0, end: 4);
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
        Get.offAll(
          () => const Home(),
          duration: const Duration(seconds: 2),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Home",
          predicate: (route) => false,
          popGesture: false,
          transition: Transition.fadeIn,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Lottie.asset(
                "assets/animations/signup/frame_1.json",
                height: 300,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
