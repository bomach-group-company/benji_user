// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/form_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderStatusChangeController extends GetxController {
  static OrderStatusChangeController get instance {
    return Get.find<OrderStatusChangeController>();
  }

  var isLoad = false.obs;

  var order = Order.fromJson(null).obs;

  Future setOrder(Order newOrder) async {
    order.value = newOrder;
    update();
    // refreshOrder();
  }

  deleteCachedOrder() {
    order.value = Order.fromJson(null);
    update();
  }

  resetOrder() async {
    order.value = Order.fromJson(null);
    update();
  }

  Future refreshOrder() async {
    var url = "${Api.baseUrl}/orders/order/${order.value.id}";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    OrderController.instance.getOrders();

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      order.value = Order.fromJson(jsonDecode(responseData));
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  orderReceived() async {
    isLoad.value = true;
    update();

    var url =
        "${Api.baseUrl}/orders/userToRiderChangeStatus?order_id=${order.value.id}";
    await FormController.instance.getAuth(url, 'orderReceived');

    if (FormController.instance.status.toString().startsWith('2')) {}
    await refreshOrder();
  }

  orderDelivered() async {
    isLoad.value = true;

    update();
    var url =
        "${Api.baseUrl}/orders/userToRiderChangeStatus?order_id=${order.value.id}";
    await FormController.instance.getAuth(url, 'deliveredOrder');
    if (FormController.instance.status.toString().startsWith('2')) {}
    await refreshOrder();
  }
}
