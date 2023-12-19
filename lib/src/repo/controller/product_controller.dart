// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class ProductController extends GetxController {
  static ProductController get instance {
    return Get.find<ProductController>();
  }

  var isLoad = false.obs;
  var isLoadVendor = false.obs;
  var isLoadCreate = false.obs;
  var vendorProducts = <Product>[].obs;
  var products = <Product>[].obs;
  var productsBySubCategory = <Product>[].obs;
  var selectedSubCategory = SubCategory.fromJson(null).obs;

  // product pagination
  var loadedAllProduct = false.obs;
  var isLoadMoreProduct = false.obs;
  var loadNumProduct = 10.obs;

  // product pagination
  var loadedAllProductSubCategory = false.obs;
  var isLoadMoreProductSubCategory = false.obs;
  var loadNumProductSubCategory = 10.obs;

  resetproductsBySubCategory() {
    loadNumProductSubCategory.value = 10;
    loadedAllProductSubCategory.value = false;
    productsBySubCategory.value = [];
    selectedSubCategory.value = SubCategory.fromJson(null);
    update();
  }

  setSubCategory(SubCategory value) async {
    selectedSubCategory.value = value;
    print(value);
    print('in the setSubCategory and has val');
    loadNumProductSubCategory.value = 10;
    loadedAllProductSubCategory.value = false;
    update();
    await getProductsBySubCategory();
  }

  Future<void> scrollListenerProduct(scrollController) async {
    if (ProductController.instance.loadedAllProduct.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      ProductController.instance.isLoadMoreProduct.value = true;
      update();
      await ProductController.instance.getProduct();
    }
  }

  Future getProduct() async {
    if (loadedAllProduct.value) {
      return;
    }

    isLoad.value = true;

    var url =
        "${Api.baseUrl}/products/listProduct?start=${loadNumProduct.value - 10}&end=${loadNumProduct.value}";
    loadNumProduct.value += 10;
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
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      products.value += data;
    } catch (e) {
      debugPrint(e.toString());
    }
    loadedAllProduct.value = data.isEmpty;
    isLoad.value = false;
    isLoadMoreProduct.value = false;
    update();
  }

  Future getProductsBySubCategory() async {
    if (loadedAllProductSubCategory.value) {
      return;
    }
    isLoad.value = true;
    update();
    var url =
        "${Api.baseUrl}/clients/filterProductsBySubCategory/${selectedSubCategory.value.id}?start=${loadNumProductSubCategory.value - 10}&end=${loadNumProductSubCategory.value}";
    loadNumProductSubCategory.value += 10;
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
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      productsBySubCategory.value += data;
    } catch (e) {
      debugPrint(e.toString());
    }
    loadedAllProductSubCategory.value = data.isEmpty;
    isLoad.value = false;
    isLoadMoreProductSubCategory.value = false;
    update();
  }

  Future getProductsByVendorAndSubCategory(
      String vendorId, String subCategoryId) async {
    isLoadVendor.value = true;
    update();
    var url =
        "${Api.baseUrl}/clients/filterVendorsProductsBySubCategory/$vendorId/$subCategoryId/";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadVendor.value = false;
      update();
      return;
    }
    List<Product> data = [];
    try {
      data = (jsonDecode(response!.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      vendorProducts.value += data;
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoadVendor.value = false;
    update();
  }
}
