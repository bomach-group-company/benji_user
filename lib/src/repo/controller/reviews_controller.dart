// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/rating/ratings.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewsController extends GetxController {
  static ReviewsController get instance {
    return Get.find<ReviewsController>();
  }

  var isLoad = false.obs;

  var ratingValueVendor = 0.obs;
  var reviewsVendor = <Ratings>[].obs;
  var vendor = BusinessModel.fromJson(null).obs;

  var reviewsProduct = <Ratings>[].obs;
  var ratingValueProduct = 0.obs;
  var product = Product.fromJson(null).obs;

  // product
  Future<void> scrollListenerProduct(scrollController, [int value = 0]) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setRatingValueProduct(value);
    }
  }

  Future setRatingValueProduct([int value = 0]) async {
    ratingValueProduct.value = value;
    reviewsProduct.value = [];
    update();
    await getReviewsProduct();
  }

  Future getReviewsProduct([int? value]) async {
    isLoad.value = true;

    try {
      reviewsProduct.value = await getRatingsByProductIdAndOrRating(
          value ?? ratingValueProduct.value);
    } catch (e) {
      consoleLog(e.toString());
    }
    isLoad.value = false;
    update();
  }

  Future<List<Ratings>> getRatingsByProductIdAndOrRating(int rating,
      {start = 0, end = 100}) async {
    // url to be changed to vendor endpoint
    late http.Response response;
    if (rating != 0) {
      response = await http.get(
        Uri.parse(
            '$baseURL/clients/filterProductReviewsByRating/${product.value.id}?rating_value=$rating'),
        headers: authHeader(),
      );
      if (response.statusCode == 200) {
        List data = (jsonDecode(response.body) as List);

        return (data).map((item) => Ratings.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      response = await http.get(
        Uri.parse('$baseURL/clients/listAllProductRatings/${product.value.id}'),
        headers: authHeader(),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return (data).map((item) => Ratings.fromJson(item)).toList();
      } else {
        return [];
      }
    }
  }

  // vendor
  Future<void> scrollListenerVendor(scrollController, [int value = 0]) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setRatingValueVendor(value);
    }
  }

  Future setRatingValueVendor([int value = 0]) async {
    ratingValueVendor.value = value;
    reviewsVendor.value = [];
    update();
    await getReviewsVendor();
  }

  Future getReviewsVendor([int? value]) async {
    isLoad.value = true;

    try {
      reviewsVendor.value = await getRatingsByVendorIdAndOrRating(
          value ?? ratingValueVendor.value);
    } catch (e) {
      consoleLog(e.toString());
    }
    isLoad.value = false;
    update();
  }

  Future<List<Ratings>> getRatingsByVendorIdAndOrRating(int rating,
      {start = 0, end = 100}) async {
    // url to be changed to vendor endpoint
    late http.Response response;
    if (rating != 0) {
      response = await http.get(
        Uri.parse(
            '$baseURL/clients/filterVendorReviewsByRating/${vendor.value.id}?rating_value=$rating'),
        headers: authHeader(),
      );
      if (response.statusCode == 200) {
        List data = (jsonDecode(response.body) as List);

        return (data).map((item) => Ratings.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      response = await http.get(
        Uri.parse(
            '$baseURL/vendors/${vendor.value.id}/getAllVendorRatings?start=$start&end=$end'),
        headers: authHeader(),
      );

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        return (data['items'] as List)
            .map((item) => Ratings.fromJson(item))
            .toList();
      } else {
        return [];
      }
    }
  }
}
