import 'dart:convert';

import 'package:benji/src/repo/services/api_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../utils/helpers.dart';

const defaultImage =
    'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg';

class Category {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Category(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
      image: json['image'] == null || json['image'] == ""
          ? defaultImage
          : baseImage + json['image'],
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
