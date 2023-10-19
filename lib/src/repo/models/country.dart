import 'package:benji/src/repo/utils/constant.dart';

class Country {
  final String? code;
  final String? name;

  Country({
    this.code,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'] ?? NA,
      name: json['name'] ?? NA,
    );
  }
}
