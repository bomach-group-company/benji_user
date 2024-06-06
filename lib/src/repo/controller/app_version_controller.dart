// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/models/app_version.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppVersionController extends GetxController {
  static AppVersionController get instance {
    return Get.find<AppVersionController>();
  }

  var current = AppVersion.fromJson(null).obs;

  Future getLatest() async {
    String os = "";
    String app = "user";
    if (Platform.isAndroid) {
      os = "android";
    } else if (Platform.isIOS) {
      os = "ios";
    } else {
      return;
    }

    var url = "${Api.baseUrl}//api/v1/app-version/getLatestAppVersion/$os/$app";

    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: await authHeader());
      current.value = AppVersion.fromJson(jsonDecode(response.body));
    } catch (e) {}
  }
}
