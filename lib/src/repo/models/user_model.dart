import 'dart:convert';

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
  // final String password;
  // final String address;

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
    // required this.password,
    // required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      image: json['image'],
      token: json['token'],
      // password: json['password'],
      // address: json['address'],
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
