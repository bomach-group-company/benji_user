import 'dart:convert';

import 'package:benji/app/shopping_location/set_shopping_location.dart';
import 'package:benji/main.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth/login.dart';
import '../controller/error_controller.dart';
import '../models/user/user_model.dart';

Future<void> saveUser(String user, String token) async {
  Map data = jsonDecode(user);
  data['token'] = token;
  await prefs.setString('user', jsonEncode(data));
}

Future<User?> getUser() async {
  String? user = prefs.getString('user');
  if (user == null) {
    return null;
  }
  return modelUser(user);
}

User? getUserSync() {
  String? user = prefs.getString('user');
  if (user == null) {
    return null;
  }
  return modelUser(user);
}

checkUserAuth() async {
  User? haveUser = await getUser();
  if (haveUser == null) {
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

checkIfShoppingLocation(context) async {
  await Future.delayed(const Duration(microseconds: 1));
  if (!checkShoppingLocation()) {
    mySnackBar(
      context,
      kAccentColor,
      "Set shopping location!",
      "Please set shopping location",
      const Duration(seconds: 2),
    );

    return Get.to(
      () => const SetShoppingLocation(),
      routeName: 'SetShoppingLocation',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }
}

checkAuth(context) async {
  User? haveUser = await getUser();
  bool? isAuth = await isAuthorizedOrNull();
  if (isAuth == null) {
    ApiProcessorController.errorSnack("Please connect to the internet");
    // mySnackBar(
    //   context,
    //   kAccentColor,
    //   "No Internet!",
    //   "Please Connect to the internet",
    //   const Duration(seconds: 3),
    // );
  }
  if (haveUser == null || isAuth == false) {
    ApiProcessorController.errorSnack("Please login to continue");

    // mySnackBar(
    //   context,
    //   kAccentColor,
    //   "Login to continue!",
    //   "Please login to continue",
    //   const Duration(seconds: 2),
    // );
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

Future<bool> deleteUser() async {
  prefs.remove('userData');
  return prefs.remove('user');
}

Future<Map<String, String>> authHeader(
    [String? authToken, String? contentType]) async {
  if (authToken == null) {
    User? user = await getUser();
    if (user != null) {
      authToken = user.token;
    }
  }

  Map<String, String> res = {
    'Authorization': 'Bearer $authToken',
  };
  // 'Content-Type': 'application/json', 'application/x-www-form-urlencoded'

  if (contentType != null) {
    res['Content-Type'] = contentType;
  }
  return res;
}

Future<bool?> isAuthorizedOrNull() async {
  try {
    final response = await http.get(
      Uri.parse('$baseURL/auth/'),
      headers: await authHeader(),
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      if (data["detail"] == "Unauthorized") {
        return false;
      }
      return true;
    }
    return false;
  } catch (e) {
    return null;
  }
}

// Future<bool> isLoggedIn() async {
//   try {
//     final response = await http.get(
//       Uri.parse('$baseURL/auth/'),
//       headers: await authHeader(),
//     );
//     if (response.statusCode == 200) {
//       dynamic data = jsonDecode(response.body);
//       if (data["detail"] == "Unauthorized") {
//         return false;
//       }
//       return true;
//     }
//     return false;
//   } catch (e) {
//     return null;
//   }
// }
