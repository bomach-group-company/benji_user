// ignore_for_file: empty_catches

import 'dart:convert';

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
  var deliveryFee = 0.0.obs;

  Future<void> scrollListener(scrollController) async {
    if (OrderController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      OrderController.instance.isLoadMore.value = true;
      update();
      await OrderController.instance.getOrders();
    }
  }

  Future getOrders({
    bool first = false,
  }) async {
    if (first) {
      loadNum.value = 10;
    }
    if (loadedAll.value) {
      return;
    }
    if (!first) {
      isLoadMore.value = true;
    }
    isLoad.value = true;
    if (loadedAll.value) {
      return;
    }
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url = "${Api.baseUrl}${Api.myOrders}$id";
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      if (!first) {
        isLoadMore.value = false;
      }
      isLoad.value = false;
      return;
    }
    List<Order> data = [];
    try {
      data = (jsonDecode(responseData) as List)
          .map((e) => Order.fromJson(e))
          .toList();
      orderList.value += data;
    } catch (e) {
      consoleLog(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future<String> createOrder(Map<String, dynamic> formatOfOrder) async {
    consoleLog('formatOfOrder in createOrder $formatOfOrder');
    int? userId = (await getUser())!.id;

    final response = await http.post(
      Uri.parse('$baseURL/orders/create_order?client_id=$userId'),
      headers: await authHeader(),
      body: jsonEncode(formatOfOrder),
    );
    if (kDebugMode) {
      consoleLog(response.body);
      consoleLog("${response.statusCode}");
    }
    if (response.statusCode.toString().startsWith('2')) {
      String res =
          jsonDecode(response.body)['message'].toString().split(' ').last;
      print(res);
      await getDeliveryFew(res);
      return res;
    }
    throw Exception('Failed to create order');
  }

  Future getDeliveryFew(String orderId) async {
    final response = await http.get(
      Uri.parse('$baseURL/payments/getdeliveryfee/$orderId/order'),
      headers: await authHeader(),
    );
    if (kDebugMode) {
      consoleLog(response.body);
      consoleLog("${response.statusCode}");
    }
    if (response.statusCode.toString().startsWith('2')) {
      double res = (jsonDecode(response.body)['delivery_fee'] as double);
      deliveryFee.value = res;
      update();
      print(res);
      return;
    } else {
      throw Exception('Failed to get delivery fee');
    }
  }
}
