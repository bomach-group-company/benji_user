import 'dart:convert';

import 'package:benji/src/repo/models/shop_type.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../../utils/helpers.dart';

class VendorModel {
  final int id;
  final String email;
  final String phone;
  final String username;
  final String code;
  final bool isOnline;
  final String firstName;
  final String lastName;
  final String gender;
  final String address;
  final String shopName;
  final double averageRating;
  final int numberOfClientsReactions;
  final String? shopImage;
  final String? profileLogo;
  final ShopTypeModel shopType;

  VendorModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.code,
    required this.isOnline,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.shopName,
    required this.averageRating,
    required this.numberOfClientsReactions,
    required this.shopImage,
    required this.profileLogo,
    required this.shopType,
  });

  factory VendorModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VendorModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? NA,
      phone: json['phone'] ?? NA,
      username: json['username'] ?? NA,
      code: json['code'] ?? NA,
      isOnline: json['is_online'] ?? false,
      firstName: json['first_name'] ?? NA,
      lastName: json['last_name'] ?? NA,
      gender: json['gender'] ?? NA,
      address: json['address'] ?? NA,
      shopName: json['shop_name'] ?? NA,
      averageRating: json['average_rating'] ?? 0.0,
      numberOfClientsReactions: json['number_of_clients_reactions'] ?? 0,
      shopImage: json['shop_image'],
      profileLogo: json['profileLogo'],
      shopType: ShopTypeModel.fromJson(json['shop_type']),
    );
  }
}

Future<VendorModel> getVendorById(id) async {
  final response = await http.get(
    Uri.parse('$baseURL/vendors/getVendor/$id'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return VendorModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load vendor');
  }
}

Future<List<VendorModel>> getPopularVendors({start = 0, end = 4}) async {
  final response = await http.get(
    Uri.parse('$baseURL/clients/getPopularVendors?start=$start&end=$end'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => VendorModel.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<VendorModel>> getVendors({start = 0, end = 5}) async {
  final response = await http.get(
    Uri.parse('$baseURL/vendors/getAllVendor?start=$start&end=$end'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => VendorModel.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
