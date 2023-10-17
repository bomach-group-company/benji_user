import 'dart:convert';

import 'package:benji/src/frontend/model/sub_category.dart';
import 'package:benji/src/frontend/model/vendor.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int? quantityAvailable;
  final String? productImage;
  final bool isAvailable;
  final bool isTrending;
  final bool isRecommended;
  final Vendor vendor;
  final SubCategory subCategory;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantityAvailable,
    required this.productImage,
    required this.isAvailable,
    required this.isTrending,
    required this.isRecommended,
    required this.vendor,
    required this.subCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantityAvailable: json['quantity_available'],
      productImage: json['product_image'],
      isAvailable: json['is_available'],
      isTrending: json['is_trending'],
      isRecommended: json['is_recommended'],
      vendor: Vendor.fromJson(json['vendor']),
      subCategory: SubCategory.fromJson(json['sub_category']),
    );
  }
}

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

Future<List<Product>> fetchProducts([final int limit = 8]) async {
  final response = await http
      .get(Uri.parse('$baseFrontendUrl/products/listProduct?limit=$limit'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Product.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}
