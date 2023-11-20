// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class CategoryController extends GetxController {
  static CategoryController get instance {
    return Get.find<CategoryController>();
  }

  var isLoad = false.obs;
  var category = <Category>[].obs;

  Future getCategory() async {
    isLoad.value = true;
    late String token;
    var url = "${Api.baseUrl}${Api.category}?start=0&end=100";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      category.value = (jsonDecode(response!.body)['items'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      // ApiProcessorController.errorSnack("An error occurred ERROR: $e");
    }
    isLoad.value = false;
    update();
  }
}
