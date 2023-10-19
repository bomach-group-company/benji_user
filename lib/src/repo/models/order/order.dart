import 'dart:convert';

import 'package:benji/src/repo/utils/constant.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Order {
  final String id;
  final double totalPrice;
  final String assignedStatus;
  final String deliveryStatus;
  // final User client;
  // final Address deliveryAddress;
  // final List<OrderItem> orderItems;
  // final DateTime created;

  Order({
    required this.id,
    required this.totalPrice,
    required this.assignedStatus,
    required this.deliveryStatus,
    // required this.client,
    // required this.deliveryAddress,
    // required this.orderItems,
    // required this.created,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // List<OrderItem> orderItems = [];
    // for (var item in json['orderitems']) {
    //   orderItems.add(OrderItem.fromJson(item));
    // }

    return Order(
      id: json['id'] ?? NA,
      totalPrice: json['total_price'] ?? 0.0,
      assignedStatus: json['assigned_status'] ?? NA,
      deliveryStatus: json['delivery_status'] ?? NA,
      // client: User.fromJson(json['client']) ?? NA,
      // deliveryAddress: Address.fromJson(json['delivery_address']),
      // orderItems: orderItems,
      // created: DateTime.parse(json['created']),
    );
  }
}

Future<List<Order>> getOrders(id) async {
  final response = await http.get(
    Uri.parse('$baseURL/clients/listClientOrders/$id'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Order.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<String> createOrder(List<Map<String, dynamic>> formatOfOrder) async {
  int? userId = (await getUser())!.id;

  final response = await http.post(
    Uri.parse('$baseURL/orders/createOrder?client_id=$userId'),
    headers: await authHeader(),
    body: jsonEncode(formatOfOrder),
  );
  if (kDebugMode) {
    print(response.body);
    print(response.statusCode);
  }
  String res = jsonDecode(response.body)['message']
      .toString()
      .split('Order Created Successfully. ')[1];
  return res;
}
