import 'dart:convert';

import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

Future<List<SubCategory>> fetchSubCategories() async {
  final response =
      await http.get(Uri.parse('$baseFrontendUrl/sub_categories/list'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => SubCategory.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load sub categories');
  }
}

Future<SubCategory> fetchSubCategory(id) async {
  final response =
      await http.get(Uri.parse('$baseFrontendUrl/sub_categories/category/$id'));

  if (response.statusCode == 200) {
    return SubCategory.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load sub category');
  }
}

Future<List<SubCategory>> fetchSubCategoryFilterByCategory(
    final String categoryId,
    [final int start = 1,
    final int end = 9]) async {
  final response = await http.get(Uri.parse(
      '$baseFrontendUrl/sub_categories/filterSubCategoryByCategory?category_id=$categoryId&start=$start&end=$end'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => SubCategory.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load SubCategory');
  }
}
