import 'category_model.dart';

class SubCategory {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final Category category;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
      category: Category.fromJson(json['category']),
    );
  }
}
