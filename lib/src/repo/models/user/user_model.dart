import 'dart:convert';

import 'package:benji/src/repo/utils/constants.dart';

class User {
  final int id;
  final String email;
  final String phone;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String token;
  final String code;

  const User({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
    required this.code,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      username: json['username'] ?? notAvailable,
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
      gender: json['gender'] ?? notAvailable,
      image: json['image'] == null || json['image'] == "" ?  'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg': json['image'],
      token: json['token'] ?? notAvailable,
      code: json['code'] ?? notAvailable,
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
