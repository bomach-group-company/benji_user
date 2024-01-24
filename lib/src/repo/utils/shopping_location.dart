import 'dart:convert';

import 'package:benji/main.dart';

String instanceNameShoppingLocation = 'shoppingLocation';

Future<bool> setShoppingLocation(
    String country, String state, String city) async {
  Map<String, String> area = {'country': country, 'state': state, 'city': city};

  print('area $area');
  return await prefs.setString(instanceNameShoppingLocation, jsonEncode(area));
}

bool checkShoppingLocation() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  return data != null;
}

Map<String, dynamic>? getShoppingLocation() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  return data == null ? null : (jsonDecode(data) as Map<String, dynamic>);
}

String? getShoppingLocationPath({bool reverse = false}) {
  String? data = prefs.getString(instanceNameShoppingLocation);
  if (data == null) {
    return null;
  }
  dynamic result = jsonDecode(data);
  if (reverse) {
    return "${result['country']}/${result['state']}/${result['city']}";
  }
  return "${result['city']}/${result['state']}/${result['country']}";
}

String? getShoppingLocationQuery() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  if (data == null) {
    return null;
  }
  dynamic result = jsonDecode(data);

  return "countryCode=${result['country']}&state=${result['state']}&city=${result['city']}";
}

String getShoppingLocationString() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  if (data == null) {
    return '';
  }
  dynamic result = jsonDecode(data);

  return "${result['city']}, ${result['state']}, ${result['country']}";
}
