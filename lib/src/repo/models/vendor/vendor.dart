import 'dart:convert';

import 'package:benji/src/repo/models/shop_type.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../../utils/helpers.dart';

class VendorModel {
  int id;
  String token;
  String email;
  String phone;
  String username;
  String code;
  String firstName;
  String lastName;
  String gender;
  String address;
  String longitude;
  String latitude;
  bool isOnline;
  double averageRating;
  int numberOfClientsReactions;
  String shopName;
  String shopImage;
  String profileLogo;
  ShopTypeModel shopType;
  String weekOpeningHours;
  String weekClosingHours;
  String satOpeningHours;
  String satClosingHours;
  String sunWeekOpeningHours;
  String sunWeekClosingHours;

  VendorModel({
    required this.id,
    required this.token,
    required this.email,
    required this.phone,
    required this.username,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.isOnline,
    required this.averageRating,
    required this.numberOfClientsReactions,
    required this.shopName,
    required this.shopImage,
    required this.profileLogo,
    required this.shopType,
    required this.weekOpeningHours,
    required this.weekClosingHours,
    required this.satOpeningHours,
    required this.satClosingHours,
    required this.sunWeekOpeningHours,
    required this.sunWeekClosingHours,
  });

  factory VendorModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VendorModel(
      id: json["id"] ?? 0,
      token: json["token"] ?? '',
      email: json["email"] ?? notAvailable,
      phone: json["phone"] ?? notAvailable,
      username: json["username"] ?? notAvailable,
      code: json["code"] ?? notAvailable,
      firstName: json["first_name"] ?? notAvailable,
      lastName: json["last_name"] ?? notAvailable,
      gender: json["gender"] ?? notAvailable,
      address: json["address"] ?? notAvailable,
      longitude: json["longitude"] ?? notAvailable,
      latitude: json["latitude"] ?? notAvailable,
      isOnline: json["is_online"] ?? false,
      averageRating: ((json["average_rating"] ?? 0.0) as double).toPrecision(1),
      numberOfClientsReactions: json["number_of_clients_reactions"] ?? 0,
      shopName: json["shop_name"] ?? notAvailable,
      shopImage: json["shop_image"] ?? '',
      profileLogo: json["profileLogo"] ?? '',
      weekOpeningHours: json["weekOpeningHours"] ?? notAvailable,
      weekClosingHours: json["weekClosingHours"] ?? notAvailable,
      satOpeningHours: json["satOpeningHours"] ?? notAvailable,
      satClosingHours: json["satClosingHours"] ?? notAvailable,
      sunWeekOpeningHours: json["sunWeekOpeningHours"] ?? notAvailable,
      sunWeekClosingHours: json["sunWeekClosingHours"] ?? notAvailable,
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
