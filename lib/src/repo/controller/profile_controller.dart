// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/app/auth/login.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app/no_network/no_network_retry.dart';

class ProfileController extends GetxController {
  static ProfileController get instance {
    return Get.find<ProfileController>();
  }

  bool? isFirst;
  ProfileController({this.isFirst});

  var user = User.fromJson(null).obs;

//===================== Update Personal Profile ==================\\

  Future<bool> updateProfile({
    String? phoneNumber,
    firstName,
    lastName,
  }) async {
    late String token;
    token = UserController.instance.user.value.token;
    int uuid = UserController.instance.user.value.id;

    var url = "${Api.baseUrl}/clients/changeClient/$uuid";

    Map body = {
      "first_name": firstName ?? "",
      "last_name": lastName ?? "",
      "phone": phoneNumber ?? "",
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": content,
        },
        body: {'data': jsonEncode(body)},
      );
      consoleLog(response.body);
      //Print the response in the console:
      // will do this when the endpoint stops returning null (save the new data)
      UserController.instance
          .saveUser(response.body, UserController.instance.user.value.token);

      if (response.statusCode == 200) {
        ApiProcessorController.successSnack(
            "Your changes have been saved successfully.");
      } else {
        ApiProcessorController.errorSnack(
            "Something went wrong, please try again.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
      await  Get.to(
            () => const NoNetworkRetry(),
        routeName: 'NoNetworkScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e \nPlease contact support.");
    }

    return false;
  }

//===================== Change Password ==================\\

  Future<void> changePassword(
      {String? oldPassword,
      newPassword,
      confirmPassword,
      bool isCurrent = true}) async {
    late String token;

    var url = "${Api.baseUrl}${Api.changePassword}";
    token = UserController.instance.user.value.token;

    Map body = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          "Content-Type": content,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: body,
      );

      // var jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ApiProcessorController.successSnack("Password Changed Successfully");
        await UserController.instance.deleteUser();

        Get.offAll(
          () => const Login(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Login",
          predicate: (route) => false,
          popGesture: true,
          transition: Transition.rightToLeft,
        );
        return;
      } else {
        ApiProcessorController.errorSnack("Invalid, please try again.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
      await  Get.to(
            () => const NoNetworkRetry(),
        routeName: 'NoNetworkScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
      return;
    } catch (e) {
      consoleLog(e.toString());
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e \nPlease try again.");
    }
  }
}
