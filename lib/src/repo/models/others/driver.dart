import 'package:benji/src/repo/utils/constant.dart';

class Driver {
  final String id;
  final String firstName;
  final String lastName;

  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Driver.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Driver(
      id: json['id'] ?? notAvailable,
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
    );
  }
}
