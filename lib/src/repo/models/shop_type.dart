import 'package:benji/src/repo/utils/constant.dart';

class ShopTypeModel {
  final String? id;
  final String? name;
  final String? description;
  final bool? isActive;

  ShopTypeModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
  });

  factory ShopTypeModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShopTypeModel(
      id: json['id'] ?? NA,
      name: json['name'] ?? NA,
      description: json['description'] ?? NA,
      isActive: json['is_active'] ?? false,
    );
  }
}
