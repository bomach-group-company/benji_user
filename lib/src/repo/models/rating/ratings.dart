import 'dart:convert';

import 'package:benji_user/src/repo/models/user/user_model.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:http/http.dart' as http;

import '../../utils/base_url.dart';
import '../../utils/helpers.dart';

class Ratings {
  final String? id;
  final int? ratingValue;
  final String? comment;
  final DateTime? created;
  final User client;
  final VendorModel vendor;

  Ratings({
    this.id,
    this.ratingValue,
    this.comment,
    this.created,
    required this.client,
    required this.vendor,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      id: json['id'],
      ratingValue: json['rating_value'],
      comment: json['comment'],
      created: DateTime.parse(json['created']),
      client: User.fromJson(json['client']),
      vendor: VendorModel.fromJson(json['vendor']),
    );
  }
}

Future<List<Ratings>> getRatingsByVendorId(int id,
    {start = 1, end = 10}) async {
  final response = await http.get(
    Uri.parse('$baseURL/clients/filterReviewsByRating/${id}'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load ratings');
  }
}
