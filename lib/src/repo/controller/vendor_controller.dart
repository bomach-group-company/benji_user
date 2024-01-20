// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'user_controller.dart';

class VendorController extends GetxController {
  static VendorController get instance {
    return Get.find<VendorController>();
  }

  var isLoad = false.obs;
  var isLoadCreate = false.obs;
  var vendorProductList = <Product>[].obs;
  var loadSimilarVendor = false.obs;
  // vendor pagination
  var loadNumVendor = 10.obs;
  var loadedAllVendor = false.obs;
  var isLoadMoreVendor = false.obs;
  var vendorList = <VendorModel>[].obs;
  var similarVendors = <VendorModel>[].obs;

  // vendor pagination
  var loadNumPopularVendor = 10.obs;
  var loadedAllPopularVendor = false.obs;
  var isLoadMorePopularVendor = false.obs;
  var vendorPopularList = <VendorModel>[].obs;

  // product pagination
  var loadedAllProduct = false.obs;
  var isLoadMoreProduct = false.obs;
  var loadNumProduct = 10.obs;

  Future<void> scrollListenerVendor(scrollController) async {
    if (VendorController.instance.loadedAllVendor.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      VendorController.instance.isLoadMoreVendor.value = true;
      update();
      await VendorController.instance.getVendors();
    }
  }

  Future<void> scrollListenerPopularVendor(scrollController) async {
    if (VendorController.instance.loadedAllVendor.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      VendorController.instance.isLoadMoreVendor.value = true;
      update();
      await VendorController.instance.getPopularVendors();
    }
  }

  Future<void> scrollListenerProduct(scrollController, vendorId) async {
    if (VendorController.instance.loadedAllProduct.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      VendorController.instance.isLoadMoreProduct.value = true;
      update();
      await VendorController.instance.getVendorProduct(vendorId);
    }
  }

  Future getVendors() async {
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/clients/getbusinessesByLocation/${getShoppingLocationPath()}";
    print(url);
    token = UserController.instance.user.value.token;
    List<VendorModel> data = [];
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      print(response!.body);
      data = (jsonDecode(response.body) as List)
          .map((e) => VendorModel.fromJson(e))
          .toList();
      vendorList.value = data;
    } catch (e) {}
    isLoad.value = false;

    update();
  }

  Future getPopularVendors({int? start, int? end}) async {
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.popularVendor}?start=${start ?? loadNumPopularVendor.value - 10}&end=${end ?? loadNumPopularVendor.value}";
    if (end == null) {
      loadNumPopularVendor.value += 10;
    }

    token = UserController.instance.user.value.token;
    List<VendorModel> data = [];
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => VendorModel.fromJson(e))
          .toList();
      vendorPopularList.value += data;
    } catch (e) {}
    isLoad.value = false;
    isLoadMorePopularVendor.value = false;
    loadedAllPopularVendor.value = data.isEmpty;

    update();
  }

  Future getVendorProduct(
    id, {
    bool first = false,
  }) async {
    if (first) {
      loadNumProduct.value = 10;
    }
    if (loadedAllProduct.value) {
      return;
    }
    if (!first) {
      isLoadMoreProduct.value = true;
    }
    isLoad.value = true;

    var url =
        "${Api.baseUrl}${Api.getVendorProducts}$id/listMyProducts?start=${loadNumProduct.value - 10}&end=${loadNumProduct.value}";
    loadNumProduct.value += 10;
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoad.value = false;
      if (!first) {
        isLoadMoreProduct.value = false;
      }

      update();
      return;
    }
    List<Product> data = [];
    try {
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      vendorProductList.value += data;
    } catch (e) {
      debugPrint(e.toString());
    }
    loadedAllProduct.value = data.isEmpty;
    isLoad.value = false;
    isLoadMoreProduct.value = false;

    update();
  }

  Future getSimilarVendors(String vendorId) async {
    loadSimilarVendor.value = true;
    var url =
        "${Api.baseUrl}/clients/similarbusiness/${getShoppingLocationPath(reverse: true)}";
    print(url);
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    print('similar vendor ${response!.body}');

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      loadSimilarVendor.value = false;
      update();
      return;
    }
    List<VendorModel> data = [];
    try {
      data = (jsonDecode(response.body) as List)
          .map((e) => VendorModel.fromJson(e))
          .toList();
      similarVendors.value = data.length < 5 ? data : data.sublist(0, 5);
    } catch (e) {
      debugPrint(e.toString());
    }
    loadSimilarVendor.value = false;
    update();
  }
}
