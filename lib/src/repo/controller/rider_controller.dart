// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class RiderController extends GetxController {
  static RiderController get instance {
    return Get.find<RiderController>();
  }

  var isLoad = false.obs;
  var isAssigning = false.obs;
  var riders = <Product>[].obs;

  Future getAvailableRiders() async {
    isLoad.value = true;

    var url = "${Api.baseUrl}/tasks/listAvailableRidersForTask";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }
    List<Product> data = [];
    try {
      data = (jsonDecode(response!.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      riders.value += data;
    } catch (e) {
      log(e.toString());
    }
    isLoad.value = false;
    update();
  }
}
