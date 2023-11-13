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

class SubCategoryController extends GetxController {
  static SubCategoryController get instance {
    return Get.find<SubCategoryController>();
  }

  var isLoad = false.obs;
  var subcategory = <SubCategory>[].obs;
  var selectedCategory = Category.fromJson(null).obs;

  setCategory(Category value) async {
    selectedCategory.value = value;
    update();
    await getSubCategory();
  }

  Future getSubCategory() async {
    isLoad.value = true;
    late String token;
    var url = "${Api.baseUrl}${Api.subCategory}${selectedCategory.value.id}";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      subcategory.value = (jsonDecode(response!.body) as List)
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
