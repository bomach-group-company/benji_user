// ignore_for_file: empty_catches

import 'package:benji/app/auth/login.dart';
import 'package:benji/app/home/home.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/repo/controller/category_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future checkAuth() async {
    if (await isAuthorized()) {
      Get.offAll(
        () => const Home(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Home",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    } else {
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    }
  }

  Future loginIfNotAuth(context) async {
    User? haveUser = await getUser();
    bool? isAuth = await isAuthorizedOrNull();
    if (isAuth == null) {
      mySnackBar(
        context,
        kAccentColor,
        "No Internet!",
        "Please Connect to the internet",
        const Duration(seconds: 3),
      );
    }
    if (haveUser == null || isAuth == false) {
      mySnackBar(
        context,
        kAccentColor,
        "Login to continue!",
        "Please login to continue",
        const Duration(seconds: 2),
      );
      await UserController.instance.deleteUser();
      return Get.offAll(
        () => const Login(),
        routeName: 'Login',
        predicate: (route) => false,
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        transition: Transition.rightToLeft,
      );
    }
  }
}