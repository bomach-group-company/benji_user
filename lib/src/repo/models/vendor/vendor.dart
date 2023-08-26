import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/base_url.dart';

class VendorModel {
  final int? id;
  final String? email;
  final String? phone;
  final bool? isActiveCustomUserVerified;
  final String? username;
  final String? code;
  final bool? isOnline;
  final String? created;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? shopName;
  final String? balance;

  VendorModel({
    this.id,
    this.email,
    this.phone,
    this.isActiveCustomUserVerified,
    this.username,
    this.code,
    this.isOnline,
    this.created,
    this.firstName,
    this.lastName,
    this.gender,
    this.shopName,
    this.balance,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      isActiveCustomUserVerified: json['is_activeCustomUserverified'],
      username: json['username'],
      code: json['code'],
      isOnline: json['is_online'],
      created: json['created'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      shopName: json['shop_name'],
      balance: json['balance'],
    );
  }
}

Future<VendorModel> getVendorById(id) async {
  final response = await http.get(Uri.parse('$baseURL/vendors/getVendor/$id'));

  if (response.statusCode == 200) {
    return VendorModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load vendor');
  }
}

Future<List<VendorModel>> getVendors(start, end) async {
  final response = await http
      .get(Uri.parse('$baseURL/vendors/getAllVendor?start=$start&end=$end'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => VendorModel.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load vendor');
  }
}
