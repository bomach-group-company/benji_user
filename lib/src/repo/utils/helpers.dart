import 'dart:convert';

import 'package:benji_user/app/auth/forgot_password.dart';
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
    print('in get user');
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
  print(user);
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
    print(
        ' type ${data.runtimeType.toString()} ${data.runtimeType.toString() == "_JsonMap"}');

    if (data.runtimeType.toString() == '_JsonMap' &&
        data.containsKey('detail') &&
        data['detail'] == 'Unauthorized') {
      print('go to login');
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
