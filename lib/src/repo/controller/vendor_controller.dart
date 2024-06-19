// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
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
  var vendorList = <BusinessModel>[].obs;
  var similarVendors = <BusinessModel>[].obs;

  // vendor pagination
  var loadNumPopularVendor = 10.obs;
  var loadedAllPopularVendor = false.obs;
  var isLoadMorePopularVendor = false.obs;
  var vendorPopularList = <BusinessModel>[].obs;

  // product pagination
  var loadedAllProduct = false.obs;
  var isLoadMoreProduct = false.obs;
  var loadNumProduct = 10.obs;

  refreshVendor() {
    loadNumPopularVendor.value = 10;
    loadedAllVendor.value = false;
    loadedAllPopularVendor.value = false;
    vendorList.value = [];
    vendorPopularList.value = [];
    getVendors();
    getPopularBusinesses(start: 0, end: 4);
  }

  Future<void> scrollListenerVendor(scrollController) async {
    if (loadedAllVendor.value || isLoadMoreVendor.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMoreVendor.value = true;
      update();
      await getVendors();
    }
  }

  Future<void> scrollListenerPopularVendor(scrollController) async {
    if (loadedAllPopularVendor.value || isLoadMorePopularVendor.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMorePopularVendor.value = true;
      update();
      await getPopularBusinesses();
    }
  }

  Future<void> scrollListenerProduct(scrollController, vendorId) async {
    if (loadedAllProduct.value || isLoadMoreVendor.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMoreProduct.value = true;
      update();
      await getVendorProduct(vendorId);
    }
  }

  Future<String> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return '${position.latitude}/${position.longitude}';
    } catch (e) {
      return '0/0';
    }
  }

  Future getVendors() async {
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/clients/getbusinessesByLocation/${getShoppingLocationPath()}?start=${loadNumPopularVendor.value - 10}&end=${loadNumPopularVendor.value}";
    loadNumPopularVendor.value += 10;

    log(url);
    token = UserController.instance.user.value.token;
    List<BusinessModel> data = [];
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);

      data = (jsonDecode(response!.body) as List)
          .map((e) => BusinessModel.fromJson(e))
          .toList();
      vendorList.value += data;
      loadedAllVendor.value = data.isEmpty;
    } catch (e) {
      loadNumPopularVendor.value -= 10;
    }
    isLoad.value = false;
    isLoadMoreVendor.value = false;

    update();
  }

  Future getPopularBusinesses({int? start, int? end}) async {
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/clients/getPopularBusiness?start=${start ?? loadNumPopularVendor.value - 10}&end=${end ?? loadNumPopularVendor.value}";
    if (end == null) {
      loadNumPopularVendor.value += 10;
    }

    token = UserController.instance.user.value.token;
    List<BusinessModel> data = [];
    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => BusinessModel.fromJson(e))
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
    log(url);
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      loadSimilarVendor.value = false;
      update();
      return;
    }
    List<BusinessModel> data = [];
    try {
      data = (jsonDecode(response!.body) as List)
          .map((e) => BusinessModel.fromJson(e))
          .toList();
      similarVendors.value = data.length < 5 ? data : data.sublist(0, 5);
    } catch (e) {
      debugPrint(e.toString());
    }
    loadSimilarVendor.value = false;
    update();
  }
}
