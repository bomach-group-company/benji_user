// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class SubCategoryController extends GetxController {
  static SubCategoryController get instance {
    return Get.find<SubCategoryController>();
  }

  var isLoadForAll = false.obs;
  var isLoad = false.obs;
  var allSubcategoryByVendor = <SubCategory>[].obs;
  var activeSubCategory = SubCategory.fromJson(null).obs;

  var subcategory = <SubCategory>[].obs;
  var selectedCategory = Category.fromJson(null).obs;

  setCategory(Category value) {
    selectedCategory.value = value;
    subcategory.value = [];
    update();
    ProductController.instance.resetproductsBySubCategory();
  }

  setSubCategory(SubCategory value, BusinessModel vendor) {
    activeSubCategory.value = value;
    update();
    ProductController.instance
        .getProductsByVendorAndSubCategory(vendor.id.toString(), value.id);
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
      isLoad.value = false;

      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      // ApiProcessorController.errorSnack("An error occurred ERROR: $e");
    }
    isLoad.value = false;
    update();
  }

  Future getSubCategoryAllByVendor(String vendorId) async {
    allSubcategoryByVendor.value = [];
    isLoadForAll.value = true;
    ProductController.instance.vendorProducts.value = [];

    late String token;
    var url = "${Api.baseUrl}/clients/getBusinessSubCategories/$vendorId";
    token = UserController.instance.user.value.token;
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = ApiProcessorController.errorState(response);
      allSubcategoryByVendor.value = (jsonDecode(response!.body) as List)
          .map((e) => SubCategory.fromJson(e))
          .toList();
      isLoadForAll.value = false;
      if (allSubcategoryByVendor.isNotEmpty) {
        activeSubCategory.value = allSubcategoryByVendor[0];
        ProductController.instance.getProductsByVendorAndSubCategory(
          vendorId,
          activeSubCategory.value.id,
        );
      }
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      // ApiProcessorController.errorSnack("An error occurred ERROR: $e");
    }
    isLoadForAll.value = false;
    update();
  }
}
