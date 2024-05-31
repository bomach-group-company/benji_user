import 'dart:convert';

import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/constants.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

import 'category.dart';

const defaultImage =
    'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg';

class SubCategory {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final Category category;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.category,
    required this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
      category: Category.fromJson(json['category']),
      image: json['image'] == null || json['image'] == ""
          ? defaultImage
          : json['image'],
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
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => SubCategory.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
