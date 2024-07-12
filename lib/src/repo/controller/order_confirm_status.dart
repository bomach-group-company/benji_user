// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderConfirmStatusController extends GetxController {
  static OrderConfirmStatusController get instance {
    return Get.find<OrderConfirmStatusController>();
  }

  var confirmed = false.obs;
  late WebSocketChannel channelTask;

  var isLoad = false.obs;

  @override
  void onClose() {
    // Clean up resources
    closeTaskSocket();
    super.onClose();
  }

  getOrderConfirmStatus(Order order) {
    final wsUrlTask = Uri.parse('$websocketBaseUrl/confirmOrderStatus/');
    channelTask = WebSocketChannel.connect(wsUrlTask);
    channelTask.sink.add(jsonEncode({
      'order_id': order.id,
    }));

    Timer.periodic(const Duration(seconds: 10), (timer) {
      channelTask.sink.add(jsonEncode({
        'order_id': order.id,
      }));
    });

    channelTask.stream.listen((message) {
      log(message);
      confirmed.value = jsonDecode(message)['confirmed'];
      update();
    });
  }

  closeTaskSocket() {
    channelTask.sink.close();
    print('ItemController closed');
  }
}
