import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class AllVendor {
  final List<dynamic> items;
  final int total;
  final int perPage;

  const AllVendor({
    required this.items,
    required this.total,
    required this.perPage,
  });

  factory AllVendor.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AllVendor(
      items: json['items'],
      total: json['total'],
      perPage: json['per_page'],
    );
  }
}

Future<AllVendor> fetchAllVendor(final int skip) async {
  final response = await http
      .get(Uri.parse('$baseFrontendUrl/products/getAllVendor?skip=$skip'));

  if (response.statusCode == 200) {
    return AllVendor.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load vendors');
  }
}
