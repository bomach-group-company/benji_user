import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/base_url.dart';
import '../../utils/helpers.dart';
import '../others/driver.dart';
import '../percentage.dart';
import '../user/user_model.dart';
import 'order_details.dart';

class Order {
  final String id;
  final OrderDetails orderId;
  final Driver driverId;
  final double amount;
  final Percentage percentageId;
  final int status;

  Order({
    required this.id,
    required this.orderId,
    required this.driverId,
    required this.amount,
    required this.percentageId,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: OrderDetails.fromJson(json['order_id']),
      driverId: Driver.fromJson(json['driver_id']),
      amount: json['amount'].toDouble(),
      percentageId: Percentage.fromJson(json['percentage_id']),
      status: json['status'],
    );
  }
}

Future<List<Order>> fetchOrdersByDriver() async {
  User? user = await getUser();
  final response = await http
      .get(Uri.parse('$baseURL/drivers/commissionEarned/${user!.id}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Order.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
