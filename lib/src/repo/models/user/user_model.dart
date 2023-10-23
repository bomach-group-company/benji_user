import 'dart:convert';

import 'package:benji/src/repo/utils/constant.dart';

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
      email: json['email'] ?? NA,
      phone: json['phone'] ?? NA,
      username: json['username'] ?? NA,
      firstName: json['first_name'] ?? NA,
      lastName: json['last_name'] ?? NA,
      gender: json['gender'] ?? NA,
      image: json['image'] ?? NA,
      token: json['token'] ?? NA,
      code: json['code'] ?? NA,
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
