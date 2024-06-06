import 'package:benji/src/repo/utils/constants.dart';

class AppVersion {
  final String version;
  final String app;
  final String link;
  final String details;
  final String releaseDate;

  AppVersion({
    required this.version,
    required this.app,
    required this.link,
    required this.details,
    required this.releaseDate,
  });

  factory AppVersion.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AppVersion(
      version: json['version'] ?? "0",
      app: json['app'] ?? notAvailable,
      link: json['link'] ?? notAvailable,
      details: json['details'] ?? notAvailable,
      releaseDate: json['release_date'] ?? notAvailable,
    );
  }
}
