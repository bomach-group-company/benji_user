import 'dart:convert';

import 'package:benji/src/frontend/model/sub_category.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class AllSubCatogory {
  final List<SubCategory> items;
  final int total;
  final int perPage;
  final int start;
  final int end;

  AllSubCatogory({
    required this.items,
    required this.total,
    required this.perPage,
    required this.start,
    required this.end,
  });

  factory AllSubCatogory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AllSubCatogory(
      items: (json['items'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
      total: json['total'],
      perPage: json['per_page'],
      start: json['start'],
      end: json['end'],
    );
  }
}

Future<AllSubCatogory> fetchSubCategoriesFilterByCategory(
    final String categoryId,
    [final int start = 1,
    final int end = 9]) async {
  final response = await http.get(Uri.parse(
      '$baseFrontendUrl/sub_categories/filterSubCategoryByCategory?category_id=$categoryId&start=$start&end=$end'));

  if (response.statusCode == 200) {
    return AllSubCatogory.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load sub categories');
  }
}
