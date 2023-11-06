import 'dart:convert';

import 'package:benji/src/repo/models/product/product.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

Future<Product> fetchProduct(String id) async {
  String url = '$baseFrontendUrl/products/product/$id';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
}

Future<List<Product>> fetchProductFilterByCategory(final String categoryId,
    [final int start = 1, final int end = 9]) async {
  final response = await http.get(Uri.parse(
      '$baseFrontendUrl/products/filterProductByCategory?category_id=$categoryId&start=$start&end=$end'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Product.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProductFilterBySubCategory(
    final String subCategoryId,
    [final int start = 1,
    final int end = 9]) async {
  final response = await http.get(Uri.parse(
      '$baseFrontendUrl/products/filterProductBySubCategory?sub_category_id=$subCategoryId&start=$start&end=$end'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Product.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProducts([int start = 0, int end = 9]) async {
  final response = await http.get(
      Uri.parse('$baseFrontendUrl/products/listProduct?start=$start&end=$end'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Product.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}
