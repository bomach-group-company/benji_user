import 'package:benji/src/repo/utils/constant.dart';

class Country {
  final String code;
  final String name;

  Country({
    required this.code,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Country(
      code: json['code'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
    );
  }
}
