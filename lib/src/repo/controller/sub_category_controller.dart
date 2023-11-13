// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class CategoryController extends GetxController {
  static CategoryController get instance {
    return Get.find<CategoryController>();
  }

  var isLoad = false.obs;
  var sub_category = <SubCategory>[].obs;
  var selected_category = Category.fromJson(null).obs;

  setCategory(Category value) async {
    selected_category.value = value;
    update();
    await getSubCategory();
  }

  Future getSubCategory() async {
    isLoad.value = true;
    late String token;
    var url = "${Api.baseUrl}${Api.sub_category}${selected_category.value.id}";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      sub_category.value = (jsonDecode(response!.body) as List)
          .map((e) => SubCategory.fromJson(e))
          .toList();
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack("An error occurred ERROR: $e");
    }
    isLoad.value = false;
    update();
  }
}
