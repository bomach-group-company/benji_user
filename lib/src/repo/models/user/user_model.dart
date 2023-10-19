import 'dart:convert';

import 'package:benji/src/repo/utils/constant.dart';

class User {
  final int? id;
  final String? email;
  final String? phone;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;
  final String? code;

  const User({
    this.id,
    this.email,
    this.phone,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.token,
    this.code,
  });

  factory User.fromJson(Map<String, dynamic> json) {
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
