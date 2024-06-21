import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// API URLS AND HTTP CALL FUNCTIONS
const baseURL = "https://resource.bgbot.app/api/v1";
const baseImage = "https://resource.bgbot.app";

const websocketBaseUrl =
    "ws://wsbenji.bgbot.app/ws"; // the issue is that it is using ws on the backend instead of wss - "wss://wsbenji.bgbot.app/ws"

// const websocketBaseUrl = "ws://127.0.0.1:6388/ws";

class Api {
  static const baseUrl = "https://resource.bgbot.app/api/v1";
  static const login = "/auth/token";
  static const getClient = "/clients/getClient/";
  static const user = "/auth/";
  static const changePassword = "/auth/changeNewPassword/";

//Item Packages
  static const dispatchPackage = "/sendPackage/changePackageStatus";
  static const getPackageCategory = "/sendPackage/getPackageCategory/";
  static const getPackageWeight = "/sendPackage/getPackageWeight/";
  static const createItemPackage = "/sendPackage/createItemPackage/";

  static const vendorList = "/vendors/getAllVendor";
  static const popularVendor = "/clients/getPopularBusinesses";
  static const getVendorProducts = "/vendors/";

  static const myOrders = "/clients/listClientOrders/";
  static const category = "/categories/list";
  static const subCategory = "/sub_categories/category/";

  //Push Notification
  static const createPushNotification = "/notifier/create_push_notification";
}

String header = "application/json";
const content = "application/x-www-form-urlencoded";

class HandleData {
  static Future<http.Response?> postApi([
    String? url,
    String? token,
    dynamic body,
  ]) async {
    http.Response? response;
    try {
      if (token == null) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
              },
              body: body,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 20));
      }
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future<http.Response?> getApi([
    String? url,
    String? token,
  ]) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future put() async {}
  static Future delete() async {}
}

void consoleLog(String val) {
  for (var i = 0; i < val.length; i += 1024) {
    debugPrint(val.substring(i, i + 1024 < val.length ? i + 1024 : val.length));
  }
}

void consoleLogToFile(String val) {
  File('log.txt').writeAsStringSync(val);
}
