import 'dart:convert';

import 'package:benji_user/src/frontend/model/sub_category.dart';
import 'package:benji_user/src/frontend/model/vendor.dart';
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
