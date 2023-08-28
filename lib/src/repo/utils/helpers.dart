import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/auth/login.dart';
import '../../common_widgets/snackbar/my_floating_snackbar.dart';
import '../models/user/user_model.dart';
import 'base_url.dart';

Future<void> saveUser(String user, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map data = jsonDecode(user);
  data['token'] = token;
  await prefs.setString('user', jsonEncode(data));
}

Future<User?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('user');
  if (user == null) {
    return null;
  }
  return modelUser(user);
}

checkUserAuth() async {
  User? haveUser = await getUser();
  if (haveUser == null) {
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
}

checkAuth(context) async {
  User? haveUser = await getUser();
  bool isAuth = await isAuthorized();
  if (haveUser == null || !isAuth) {
    mySnackBar(
      context,
      "Login to continue!",
      "Please login to continue",
      Duration(seconds: 2),
    );
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
}

Future<bool> deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userData');
  return prefs.remove('user');
}

Future<Map<String, String>> authHeader(
    [String? authToken, String? contentType]) async {
  if (authToken == null) {
    User? user = await getUser();
    if (user != null) {
      authToken = user.token;
    }
  }

  Map<String, String> res = {
    'Authorization': 'Bearer $authToken',
  };
  // 'Content-Type': 'application/json'

  if (contentType != null) {
    res['Content-Type'] = contentType;
  }
  return res;
}

Future<bool> isAuthorized() async {
  final response = await http.get(
    Uri.parse('$baseURL/auth/'),
    headers: await authHeader(),
  );
  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    if (data["detail"] == "Unauthorized") {
      return false;
    }
    return true;
  }
  return false;
}
