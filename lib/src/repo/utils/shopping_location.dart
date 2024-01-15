
import 'dart:convert';

import 'package:benji/main.dart';

String instanceNameShoppingLocation = 'shoppingLocation';


Future<bool> setShoppingLocation(String country, String state, String city) async {
  Map<String, String> area = {'country': country, 'state': state, 'city': city};
    return await prefs.setString(instanceNameShoppingLocation, jsonEncode(area));
}

Map<String, String>? getShoppingLocation() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  return data == null ? null : (jsonDecode(data) as Map<String, String>);
}


String? getShoppingLocationPath() {
  String? data = prefs.getString(instanceNameShoppingLocation);
  if (data == null) {
    return null;
  }
  Map<String, String> result = (jsonDecode(data) as Map<String, String>);
  
  return "/${result['city']}/${result['state']}/${result['country']}";
}
