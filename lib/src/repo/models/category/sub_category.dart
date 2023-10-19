import 'dart:convert';

import 'package:benji/src/repo/utils/constant.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

import 'category.dart';

class SubCategory {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final Category category;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return SubCategory(
      id: json['id'] ?? NA,
      name: json['name'] ?? NA,
      description: json['description'] ?? NA,
      isActive: json['is_active'] ?? false,
      category: Category.fromJson(json['category']),
    );
  }
}

Future<List<SubCategory>> getSubCategories() async {
  final response = await http.get(Uri.parse('$baseURL/sub_categories/list'),
      headers: await authHeader());

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => SubCategory.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<SubCategory>> getSubCategoriesBycategory(id) async {
  final response = await http.get(
      Uri.parse('$baseURL/sub_categories/category/$id'),
      headers: await authHeader());
  print(response.body);
  print(response.statusCode);
  print(id);
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => SubCategory.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
