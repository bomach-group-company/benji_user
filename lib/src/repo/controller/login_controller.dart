// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:benji/app/splash_screens/login_splash_screen.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/login_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app/no_network/no_network_retry.dart';

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  var isLoad = false.obs;

  Future<void> login(SendLogin data) async {
    try {
      UserController.instance;
      isLoad.value = true;
      update();

      Map finalData = {
        "username": data.username,
        "password": data.password,
      };

      http.Response? response =
          await HandleData.postApi(Api.baseUrl + Api.login, null, finalData);

      var jsonData = jsonDecode(response?.body ?? '');

      if (jsonData["token"] == false) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }
      http.Response? responseUser =
          await HandleData.getApi(Api.baseUrl + Api.user, jsonData["token"]);

      http.Response? responseUserData = await HandleData.getApi(
          Api.baseUrl +
              Api.getClient +
              jsonDecode(responseUser?.body ?? '')['id'].toString(),
          jsonData["token"]);

      if (responseUserData == null) {
        throw const SocketException('Please connect to the internet');
      }

      UserController.instance
          .saveUser(responseUserData.body, jsonData["token"]);

      ApiProcessorController.successSnack("Login Successful");
      isLoad.value = false;
      update();
      Get.offAll(
        () => const LoginSplashScreen(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "LoginSplashScreen",
        predicate: (route) => false,
        popGesture: true,
        transition: Transition.cupertinoDialog,
      );
    }  on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
      await  Get.to(
            () => const NoNetworkRetry(),
        routeName: 'NoNetworkRetry',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    }catch (e) {
      ApiProcessorController.errorSnack("An error occurred.\n ERROR: $e");
      isLoad.value = false;
      update();
    }
  }
}
