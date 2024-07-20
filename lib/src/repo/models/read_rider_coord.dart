class ReadRiderCoord {
  bool error;
  String detail;
  String latitude;
  String longitude;

  ReadRiderCoord({
    required this.error,
    required this.detail,
    required this.latitude,
    required this.longitude,
  });

  factory ReadRiderCoord.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ReadRiderCoord(
      error: json['error'] ?? true,
      detail: json['detail'] ?? "",
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
    );
  }
}
