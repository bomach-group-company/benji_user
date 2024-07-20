class ReadRiderCoord {
  bool error;
  String detail;
  String latitude;
  String longitude;
  String firstName;
  String lastName;
  String phone;
  String image;

  ReadRiderCoord({
    required this.error,
    required this.detail,
    required this.latitude,
    required this.longitude,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
  });

  factory ReadRiderCoord.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ReadRiderCoord(
      error: json['error'] ?? true,
      detail: json['detail'] ?? "",
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
