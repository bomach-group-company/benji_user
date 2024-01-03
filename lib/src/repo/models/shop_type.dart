import 'package:benji/src/repo/utils/constants.dart';

class ShopTypeModel {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  ShopTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory ShopTypeModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShopTypeModel(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
    );
  }
}
