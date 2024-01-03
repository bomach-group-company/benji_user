import 'dart:convert';

import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/utils/constants.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class Conplain {
  final String id;
  final String topic;
  final String itemId;
  final String message;
  final bool status;
  final User user;

  Conplain({
    required this.id,
    required this.topic,
    required this.itemId,
    required this.message,
    required this.status,
    required this.user,
  });

  factory Conplain.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Conplain(
      id: json['id'] ?? '',
      topic: json['topic'] ?? '',
      itemId: json['item_id'] ?? '',
      message: json['message'] ?? notAvailable,
      status: json['status'] ?? false,
      user: User.fromJson(json['user']),
    );
  }
}

Future<bool> makeComplain(String itemId, String message, String topic) async {
  int? userId = (await getUser())!.id;
  final url = Uri.parse('$baseURL/ticket/createTicket');

  final body = {
    'topic': topic,
    'item_id': itemId,
    'message': message,
    'user_id': userId.toString(),
  };
  consoleLog("This is the body: $body");
  final response =
      await http.post(url, body: body, headers: await authHeader());
  consoleLog("This is the body response: ${response.body}");

  return response.statusCode == 200;
}

Future<List<Conplain>> getComplainsByUser() async {
  int? userId = (await getUser())!.id;

  final response = await http.get(
    Uri.parse('$baseURL/ticket/user_tickets/$userId'),
    headers: await authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Conplain.fromJson(jsonDecode(item)))
        .toList();
  } else {
    throw Exception('Failed to get user complain');
  }
}
