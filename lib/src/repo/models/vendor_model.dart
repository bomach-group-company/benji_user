class VendorModel {
  final int id;
  final String username;
  final String email;

  VendorModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
