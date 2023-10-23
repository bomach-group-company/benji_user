import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../../utils/helpers.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Category(
      id: json['id'] ?? NA,
      name: json['name'] ?? NA,
      description: json['description'] ?? NA,
      isActive: json['is_active'] ?? false,
    );
  }
}

Future<List<Category>> getCategories([start = 0, end = 100]) async {
  final response = await http.get(
      Uri.parse('$baseURL/categories/list?start=$start&end=$end'),
      headers: await authHeader());

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Category.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
