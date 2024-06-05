// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var orderList = <Order>[].obs;
  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;

  // draft order
  var isLoadDraft = false.obs;
  var orderListDraft = <Order>[].obs;
  var loadedAllDraft = false.obs;
  var isLoadMoreDraft = false.obs;
  var loadNumDraft = 10.obs;

  var deliveryFee = 0.0.obs;

  refreshOrder({paymentStatus = false}) {
    loadedAll = false.obs;
    isLoadMore = false.obs;
    loadNum = 10.obs;
    orderList.value = [];
    update();
    getOrders();
  }

  refreshOrderDraft({paymentStatus = false}) {
    loadedAllDraft = false.obs;
    isLoadMoreDraft = false.obs;
    loadNum = 10.obs;
    orderListDraft.value = [];
    update();
    getOrdersDraft();
  }

  Future<void> scrollListener(scrollController) async {
    if (loadedAll.value || isLoadMore.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMore.value = true;
      update();
      await getOrders();
    }
  }

  Future<void> scrollListenerDraft(
    scrollController,
  ) async {
    if (loadedAllDraft.value || isLoadMoreDraft.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMoreDraft.value = true;
      update();
      await getOrdersDraft();
    }
  }

  Future getOrdersDraft() async {
    if (loadedAllDraft.value) {
      return;
    }

    isLoadDraft.value = true;

    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.myOrders}$id?start=${loadNumDraft.value - 10}&end=${loadNumDraft.value}&payment_status=false";
    loadNumDraft.value += 10;

    log('in list history $url');

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadMoreDraft.value = false;
      isLoadDraft.value = false;
      update();

      return;
    }
    List<Order> data = [];
    try {
      data = (jsonDecode(responseData) as List)
          .map((e) => Order.fromJson(e))
          .toList();
      orderListDraft.value += data;
      loadedAllDraft.value = data.isEmpty;
    } catch (e) {}
    isLoadDraft.value = false;
    isLoadMoreDraft.value = false;
    update();
  }

  Future getOrders() async {
    if (loadedAll.value) {
      return;
    }

    isLoad.value = true;

    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.myOrders}$id?start=${loadNum.value - 10}&end=${loadNum.value}";
    loadNum.value += 10;

    log('in list history $url');

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadMore.value = false;
      isLoad.value = false;
      update();

      return;
    }
    List<Order> data = [];
    try {
      data = (jsonDecode(responseData) as List)
          .map((e) => Order.fromJson(e))
          .toList();
      orderList.value += data;
      loadedAll.value = data.isEmpty;
    } catch (e) {}
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future<String> createOrder(List<Map<String, dynamic>> formatOfOrder) async {
    consoleLog('formatOfOrder in createOrder $formatOfOrder');
    int? userId = (await getUser())!.id;

    final response = await http.post(
      Uri.parse('$baseURL/orders/create_order?client_id=$userId'),
      headers: await authHeader(),
      body: jsonEncode(formatOfOrder),
    );
    print(response.body);

    if (response.statusCode.toString().startsWith('2')) {
      String res =
          jsonDecode(response.body)['message'].toString().split(' ').last;
      await getDeliveryFee(res);
      return res;
    }
    throw Exception('Failed to create order');
  }

  Future getDeliveryFee(String orderId) async {
    final response = await http.get(
      Uri.parse('$baseURL/payments/getdeliveryfee/$orderId/order'),
      headers: await authHeader(),
    );
    if (kDebugMode) {
      consoleLog(response.body);
      consoleLog("${response.statusCode}");
    }
    if (response.statusCode.toString().startsWith('2')) {
      double res = (double.parse(
          (jsonDecode(response.body)['details']?['delivery_fee'] ?? 0)
              .toString()));
      deliveryFee.value = res;
      update();
      return;
    } else {
      throw Exception('Failed to get delivery fee');
    }
  }
}
