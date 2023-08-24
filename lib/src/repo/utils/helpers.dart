import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/auth/login.dart';
import '../models/user_model.dart';

Future<void> saveUser(String user, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map data = jsonDecode(user);
  data['token'] = token;
  await prefs.setString('user', jsonEncode(data));
}

Future<dynamic> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('user');
  if (user == null) {
    return Get.offAll(
      () => Login(
        logout: true,
      ),
      routeName: 'Login',
      predicate: (route) => false,
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }
  return modelUser(user);
}

Future<bool> deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userData');
  return prefs.remove('user');
}

Future<Map<String, String>> authHeader([String? authToken]) async {
  if (authToken == null) {
    User? user = await getUser();
    if (user != null) {
      authToken = user.token;
    }
  }
  return {
    'Authorization': 'Bearer $authToken',
    // 'Content-Type': 'application/json'
  };
}

dynamic isUnauthorized(String resp) {
  try {
    dynamic data = jsonDecode(resp);

    if (data.runtimeType.toString() == '_JsonMap' &&
        data.containsKey('detail') &&
        data['detail'] == 'Unauthorized') {
      return Get.offAll(
        () => Login(
          logout: true,
        ),
        routeName: 'Login',
        predicate: (route) => false,
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        transition: Transition.downToUp,
      );
    } else {
      return data;
    }
  } catch (e) {
    return resp;
  }
}
