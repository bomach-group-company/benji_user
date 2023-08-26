import 'package:benji_user/src/repo/models/category/sub_category.dart';

import '../vendor/vendor.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantityAvailable;
  final String productImage;
  final bool isAvailable;
  final bool isTrending;
  final bool isRecommended;
  final VendorModel vendorId;
  final SubCategory subCategoryId;

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
    required this.vendorId,
    required this.subCategoryId,
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
      vendorId: VendorModel.fromJson(json['vendor_id']),
      subCategoryId: SubCategory.fromJson(json['sub_category_id']),
    );
  }
}
