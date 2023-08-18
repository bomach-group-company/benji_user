import 'dart:convert';

class User {
  final int id;
  final String email;
  final String password;
  final String phone;
  final bool isActiveCustomUserverified;
  final String username;
  final String created;
  final String firstName;
  final bool isOnline;
  final String address;
  final String image;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.phone,
    required this.isActiveCustomUserverified,
    required this.username,
    required this.created,
    required this.firstName,
    required this.isOnline,
    required this.address,
    required this.image,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      isActiveCustomUserverified: json['is_activeCustomUserverified'],
      username: json['username'],
      created: json['created'],
      firstName: json['first_name'],
      isOnline: json['is_online'],
      address: json['address'],
      image: json['image'],
      token: json['token'],
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
