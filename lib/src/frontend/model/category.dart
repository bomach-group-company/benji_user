import 'dart:convert';

import 'package:benji/src/repo/models/category/category.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

Future<List<Category>> fetchCategories([int start = 0, int end = 100]) async {
  final response = await http
      .get(Uri.parse('$baseFrontendUrl/categories/list?start=$start&end=$end'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Category.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<Category> fetchCategory(id) async {
  final response =
      await http.get(Uri.parse('$baseFrontendUrl/categories/category/$id'));

  if (response.statusCode == 200) {
    return Category.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load category');
  }
}
