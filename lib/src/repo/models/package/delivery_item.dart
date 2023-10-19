import 'dart:convert';

import 'package:benji/src/repo/models/package/item_category.dart';
import 'package:benji/src/repo/models/package/item_weight.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/utils/constant.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class DeliveryItem {
  final String id;
  final User clientId;
  final String pickUpAddress;
  final String senderName;
  final String senderPhoneNumber;
  final String dropOffAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String itemName;
  final ItemCategory itemCategory;
  final ItemWeight itemWeight;
  final int itemQuantity;
  final int itemValue;
  final String? itemImage;
  final double prices;
  final String status;

  DeliveryItem({
    required this.id,
    required this.clientId,
    required this.pickUpAddress,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.dropOffAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.itemName,
    required this.itemCategory,
    required this.itemWeight,
    required this.itemQuantity,
    required this.itemValue,
    required this.itemImage,
    required this.prices,
    required this.status,
  });

  factory DeliveryItem.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return DeliveryItem(
      id: json['id'] ?? NA,
      clientId: User.fromJson(json['client']),
      pickUpAddress: json['pickUpAddress'] ?? NA,
      senderName: json['senderName'] ?? NA,
      senderPhoneNumber: json['senderPhoneNumber'] ?? NA,
      dropOffAddress: json['dropOffAddress'] ?? NA,
      receiverName: json['receiverName'] ?? NA,
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? NA,
      itemName: json['itemName'] ?? NA,
      itemCategory: ItemCategory.fromJson(json['itemCategory']),
      itemWeight: ItemWeight.fromJson(json['itemWeight']),
      itemQuantity: json['itemQuantity'] ?? 0,
      itemValue: json['itemValue'] ?? NA,
      itemImage: json['itemImage'],
      prices: json['prices'] ?? 0.0,
      status: json['status'] ?? NA,
    );
  }
}

Future<List<DeliveryItem>> getDeliveryItemsByClientAndStatus(
    String status) async {
  User? user = await getUser();
  final response = await http.get(
      Uri.parse(
          '$baseURL/sendPackage/gettemPackageByClientId/${user!.id}/$status'),
      headers: await authHeader());
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => DeliveryItem.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load delivery items');
  }
}

Future<DeliveryItem> getDeliveryItemById(id) async {
  final response = await http.get(
      Uri.parse('$baseURL/sendPackage/gettemPackageById/$id/'),
      headers: await authHeader());

  if (response.statusCode == 200) {
    return DeliveryItem.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load delivery item');
  }
}
