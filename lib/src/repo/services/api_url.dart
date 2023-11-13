import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// API URLS AND HTTP CALL FUNCTIONS
const baseURL = "https://resource.bgbot.app/api/v1";
const baseImage = "https://resource.bgbot.app";

class Api {
  static const baseUrl = "https://resource.bgbot.app/api/v1";
  static const login = "/auth/token";
  static const getClient = "/clients/getClient/";
  static const user = "/auth/";
  static const notification = "/agents/getAgentNotifications/";
  static const changePassword = "/auth/changeNewPassword/";

//Vendor
  static const vendorList = "/agents/listAllMyVendors";
  static const agentCreateVendor = "/agents/agentCreateVendor";
  static const getVendorProducts = "/agents/listVendorProducts/";
  static const filterVendorProduct =
      "/agents/filterVendorProductsBySubCategory";
  static const listVendorOrders = "/agents/listVendorOrders/";
  static const getVendorRatings = "/agents/getVendorAverageRating/";

  //order
  static const orderList = "/agents/getAllMyVendorsOrders/";

  //category
  static const category = "/categories/list";
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

consoleLog(String val) {
  return debugPrint(val);
}
