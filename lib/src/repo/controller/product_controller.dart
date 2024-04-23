// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
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
  var topProducts = <Product>[].obs;
  var similarProducts = <Product>[].obs;
  var productsBySubCategory = <Product>[].obs;
  var selectedSubCategory = SubCategory.fromJson(null).obs;
  var loadSimilarProduct = false.obs;
  var loadTopProduct = false.obs;

  // product pagination
  var hasHitLoadToVendor = false.obs;
  var loadedAllProduct = false.obs;
  var isLoadMoreProduct = false.obs;
  var loadNumProduct = 10.obs;

  // product pagination
  var isLoadProductSubCategory = false.obs;
  var loadedAllProductSubCategory = false.obs;
  var isLoadMoreProductSubCategory = false.obs;
  var loadNumProductSubCategory = 10.obs;

  refreshProduct() {
    loadNumProduct.value = 10;
    loadedAllProduct.value = false;
    topProducts.value = [];
    products.value = [];
    getTopProducts();
    getProduct();
  }

  resetproductsBySubCategory() {
    loadNumProductSubCategory.value = 10;
    loadedAllProductSubCategory.value = false;
    productsBySubCategory.value = [];
    selectedSubCategory.value = SubCategory.fromJson(null);
    update();
  }

  setSubCategory(SubCategory value) async {
    selectedSubCategory.value = value;
    loadNumProductSubCategory.value = 10;
    loadedAllProductSubCategory.value = false;
    update();
    await getProductsBySubCategory(first: true);
  }

  Future<void> scrollListenerProduct(scrollController) async {
    if (loadedAllProduct.value || isLoadMoreProduct.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMoreProduct.value = true;
      update();
      await getProduct();
    }
  }

  Future getProduct() async {
    isLoad.value = true;

    var url =
        "${Api.baseUrl}/clients/productsByUserLocation/${getShoppingLocationPath()}?start=${loadNumProduct.value - 10}&end=${loadNumProduct.value}";
    loadNumProduct.value += 10;
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadMoreProduct.value = false;
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
      log(e.toString());
    }
    loadedAllProduct.value = data.isEmpty;
    isLoad.value = false;
    isLoadMoreProduct.value = false;
    update();
  }

  Future getProductsBySubCategory({bool first = false}) async {
    if (first) {
      loadedAllProductSubCategory.value = false;
      productsBySubCategory.value = [];
    }
    if (loadedAllProductSubCategory.value) {
      return;
    }
    isLoad.value = true;
    var url =
        "${Api.baseUrl}/clients/filterProductsBySubCategory/${selectedSubCategory.value.id}/${getShoppingLocationPath(reverse: true)}?start=${loadNumProductSubCategory.value - 10}&end=${loadNumProductSubCategory.value}";
    loadNumProductSubCategory.value += 10;
    print(url);
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
      productsBySubCategory.value += data;
    } catch (e) {
      log(e.toString());
    }
    loadedAllProductSubCategory.value = data.isEmpty;
    isLoad.value = false;
    isLoadMoreProductSubCategory.value = false;
    update();
  }

  Future getProductsByVendorAndSubCategory(
      String vendorId, String subCategoryId) async {
    isLoadVendor.value = true;
    hasHitLoadToVendor.value = true;
    update();
    var url =
        "${Api.baseUrl}/clients/filterVendorsProductsBySubCategory/$vendorId/$subCategoryId";
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
      vendorProducts.value = data;
    } catch (e) {
      log(e.toString());
    }
    isLoadVendor.value = false;
    hasHitLoadToVendor.value = false;
    update();
  }

  Future getSimilarProducts(String productId) async {
    loadSimilarProduct.value = true;

    var url =
        "${Api.baseUrl}/products/similarproductCategory/?product_id=$productId&start=0&end=5";

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      loadSimilarProduct.value = false;
      update();
      return;
    }
    List<Product> data = [];
    try {
      data = (jsonDecode(response!.body)['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      similarProducts.value = data;
    } catch (e) {
      log(e.toString());
    }
    loadSimilarProduct.value = false;
    update();
  }

  Future getTopProducts() async {
    loadTopProduct.value = true;

    var url = "${Api.baseUrl}/products/getTodaysTopProducts/";

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      loadTopProduct.value = false;
      update();
      return;
    }
    List<Product> data = [];
    try {
      data = (jsonDecode(response!.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      topProducts.value = data;
    } catch (e) {
      log(e.toString());
    }
    loadTopProduct.value = false;
    update();
  }
}
