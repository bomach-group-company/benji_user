import 'dart:convert';

import 'package:benji/src/repo/utils/constant.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  // final String product;
  // final int quantity;

  OrderItem({
    required this.id,
    // required this.product,
    // required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      // product: json['product'],
      // quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'product': product,
      // 'quantity': quantity,
    };
  }
}

Future<List<OrderItem>> getOrderItems(id) async {
  final response = await http.get(
    Uri.parse('$baseURL/orders/getorderitembyid/$id'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => OrderItem.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load order items');
  }
}
