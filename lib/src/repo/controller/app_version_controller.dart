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

  Future<AppVersion> getLatest() async {
    String os = "";
    String app = "user";
    if (Platform.isAndroid) {
      os = "android";
    } else if (Platform.isIOS) {
      os = "ios";
    } else {
      return AppVersion.fromJson(null);
    }

    var url = "${Api.baseUrl}/app-version/getLatestAppVersion/$os/$app";
    print(url);
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: await authHeader());
      print(response.body);
      return AppVersion.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
    return AppVersion.fromJson(null);
  }
}
