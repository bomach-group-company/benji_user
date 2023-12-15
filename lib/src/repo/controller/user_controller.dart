// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji/app/auth/login.dart';
import 'package:benji/app/home/home.dart';
import 'package:benji/main.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  static UserController get instance {
    return Get.find<UserController>();
  }

  var isLoading = false.obs;
  var user = User.fromJson(null).obs;

  @override
  void onInit() {
    setUserSync();
    super.onInit();
  }

  bool isUSer() {
    return user.value.id != 0;
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
      Get.offAll(() => const Login());
    }
  }

  Future<void> saveUser(String user, String token) async {
    Map data = jsonDecode(user);
    data['token'] = token;

    await prefs.setString('user', jsonEncode(data));
    setUserSync();
  }

  void setUserSync() {
    String? userData = prefs.getString('user');
    if (userData == null) {
      user.value = User.fromJson(null);
    } else {
      user.value = User.fromJson(jsonDecode(userData));
    }
    update();
  }

  Future deleteUser() async {
    await prefs.remove('user');
    setUserSync();
  }

  Future getUser() async {
    http.Response? responseUserData = await HandleData.getApi(
        Api.baseUrl + Api.getClient + user.value.id.toString(),
        user.value.token);
    if (responseUserData == null || responseUserData.statusCode != 200) {
      return;
    }

    saveUser(responseUserData.body, user.value.token);
    update();
  }
}
