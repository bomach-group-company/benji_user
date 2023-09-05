import 'dart:convert';

import 'package:benji_user/src/repo/models/package/item_category.dart';
import 'package:benji_user/src/repo/models/package/item_weight.dart';
import 'package:benji_user/src/repo/utils/base_url.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class DeliveryItem {
  final String id;
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
  final String itemImage;

  DeliveryItem({
    required this.id,
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
  });

  factory DeliveryItem.fromJson(Map<String, dynamic> json) {
    return DeliveryItem(
      id: json['id'],
      pickUpAddress: json['pickUpAddress'],
      senderName: json['senderName'],
      senderPhoneNumber: json['senderPhoneNumber'],
      dropOffAddress: json['dropOffAddress'],
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      itemName: json['itemName'],
      itemCategory: ItemCategory.fromJson(json['itemCategory']),
      itemWeight: ItemWeight.fromJson(json['itemWeight']),
      itemQuantity: json['itemQuantity'],
      itemValue: json['itemValue'],
      itemImage: json['itemImage'],
    );
  }
}

Future<DeliveryItem> createDeliveryItem({
  clientId,
  pickUpAddress,
  senderName,
  senderPhoneNumber,
  dropOffAddress,
  receiverName,
  receiverPhoneNumber,
  itemName,
  itemCategoryId,
  itemWeightId,
  itemQuantity,
  itemValue,
}) async {
  Map body = {
    'client_id': clientId,
    'pickUpAddress': pickUpAddress,
    'senderName': senderName,
    'senderPhoneNumber': senderPhoneNumber,
    'dropOffAddress': dropOffAddress,
    'receiverName': receiverName,
    'receiverPhoneNumber': receiverPhoneNumber,
    'itemName': itemName,
    'itemCategory_id': itemCategoryId,
    'itemWeight': itemWeightId,
    'itemQuantity': itemQuantity,
    'itemValue': itemValue,
    // 'itemImage': itemImage,
  };

  final response = await http.post(
    Uri.parse('$baseURL/sendPackage/createItemPackage/'),
    body: body,
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return DeliveryItem.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create delivery item');
  }
}

Future<List<DeliveryItem>> getDeliveryItems() async {
  final response = await http.get(
      Uri.parse('$baseURL/sendPackage/getAllItemPackage/'),
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
      Uri.parse('$baseURL/sendPackage/gettemPackageById/${id}/'),
      headers: await authHeader());

  if (response.statusCode == 200) {
    return DeliveryItem.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load delivery item');
  }
}
