import 'dart:convert';

import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class Ratings {
  final String id;
  final double ratingValue;
  final String comment;
  final DateTime created;
  final User client;

  Ratings({
    required this.id,
    required this.ratingValue,
    required this.comment,
    required this.created,
    required this.client,
  });

  factory Ratings.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Ratings(
      id: json['id'] ?? notAvailable,
      ratingValue: json['rating_value'] ?? 0.0,
      comment: json['comment'] ?? notAvailable,
      created: json['created'] == null
          ? DateTime.now()
          : DateTime.parse(json['created']),
      client: User.fromJson(json['client']),
    );
  }
}

Future<List<Ratings>> getRatingsByVendorId(int id,
    {start = 0, end = 10}) async {
  final response = await http.get(
    Uri.parse('$baseURL/vendors/$id/getAllVendorRatings?start=$start&end=$end'),
    headers: await authHeader(),
  );
  (jsonDecode(response.body)['items'] as List)
      .map((item) => Ratings.fromJson(item))
      .toList();
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<Ratings>> getRatingsByVendorIdAndRating(int id, int rating,
    {start = 0, end = 10}) async {
  final response = await http.get(
    Uri.parse(
        '$baseURL/clients/filterVendorReviewsByRating/$id?rating_value=$rating'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<Ratings>> getRatingsByProductId(String id,
    {start = 0, end = 10}) async {
  final response = await http.get(
    Uri.parse('$baseURL/clients/listAllProductRatings/$id'),
    headers: await authHeader(),
  );
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<Ratings>> getRatingsByProductIdAndRating(String id, int rating,
    {start = 0, end = 10}) async {
  final response = await http.get(
    Uri.parse(
        '$baseURL/clients/filterProductReviewsByRating/$id?rating_value=$rating'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
