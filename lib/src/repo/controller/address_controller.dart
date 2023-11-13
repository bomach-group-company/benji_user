// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class AddressController extends GetxController {
  static AddressController get instance {
    return Get.find<AddressController>();
  }

  var isLoad = false.obs;
  var addresses = <Address>[].obs;
  var current = Address.fromJson(null).obs;

  Future getAdresses() async {
    isLoad.value = true;
    late String token;
    var url =
        "${Api.baseUrl}/clients/listMyAddresses?user_id=${UserController.instance.user.value.id}";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      addresses.value = (jsonDecode(response!.body) as List)
          .map((e) => Address.fromJson(e))
          .toList();
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack("An error occurred");
    }
    isLoad.value = false;
    update();
  }

  Future getCurrentAddress() async {
    isLoad.value = true;
    late String token;
    var url =
        "${Api.baseUrl}/clients/getCurrentAddress/${UserController.instance.user.value.id}";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      current.value = Address.fromJson(jsonDecode(response!.body));
      update();
    } catch (e) {
      current.value = Address.fromJson(null);
      ApiProcessorController.errorSnack("An error occurred");
    }
    isLoad.value = false;
    update();
  }
}
