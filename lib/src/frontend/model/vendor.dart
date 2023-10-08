import 'package:benji/src/frontend/model/shop_type.dart';

class Vendor {
  final int? id;
  final String? email;
  final String? phone;
  final String? username;
  final String? code;
  final bool? isOnline;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? address;
  final String? shopName;
  final double? averageRating;
  final int? numberOfClientsReactions;
  final String? shopImage;
  final String? profileLogo;
  final ShopTypeModel? shopType;

  Vendor({
    this.id,
    this.email,
    this.phone,
    this.username,
    this.code,
    this.isOnline = true,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    this.shopName,
    this.averageRating,
    this.numberOfClientsReactions,
    this.shopImage,
    this.profileLogo,
    this.shopType,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      code: json['code'],
      isOnline: json['is_online'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      address: json['address'],
      shopName: json['shop_name'],
      averageRating: json['average_rating'],
      numberOfClientsReactions: json['number_of_clients_reactions'],
      shopImage: json['shop_image'],
      profileLogo: json['profileLogo'],
      shopType: json['shop_type'] == null
          ? null
          : ShopTypeModel.fromJson(json['shop_type']),
    );
  }
}
