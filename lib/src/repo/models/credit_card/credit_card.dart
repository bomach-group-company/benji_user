import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/base_url.dart';
import '../../utils/helpers.dart';
import '../user/user_model.dart';

class CreditCard {
  String id;
  String cardName;
  String cardNumber;
  String ccv;
  String expiryDate;
  String created;
  User client;

  CreditCard({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.ccv,
    required this.expiryDate,
    required this.created,
    required this.client,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'],
      cardName: json['card_name'],
      cardNumber: json['card_number'],
      ccv: json['ccv'],
      expiryDate: json['expiry_date'],
      created: json['created'],
      client: User.fromJson(json['client']),
    );
  }
}

Future<CreditCard> createCreditCard(client_id, Map body) async {
  final response = await http.post(
      Uri.parse('$baseURL/clients/saveUserCard/${client_id}'),
      body: body,
      headers: await authHeader());

  if (response.statusCode == 200) {
    return CreditCard.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add credit card');
  }
}
