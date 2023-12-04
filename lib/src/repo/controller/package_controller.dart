import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/package/delivery_item.dart';
import 'package:benji/src/repo/models/package/item_category.dart';
import 'package:benji/src/repo/models/package/item_weight.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyPackageController extends GetxController {
  static MyPackageController get instance {
    return Get.find<MyPackageController>();
  }

  var isLoadDelivered = false.obs;
  var isLoadPending = false.obs;
  var isLoad = false.obs;
  var packageCategory = <ItemCategory>[].obs;
  var packageWeight = <ItemWeight>[].obs;
  var pendingPackages = <DeliveryItem>[].obs;
  var deliveredPackages = <DeliveryItem>[].obs;

  Future getDeliveryItemsByPending() async {
    print('got to the getDeliveryItemsByPending');
    isLoadPending.value = true;
    update();
    User? user = UserController.instance.user.value;
    final response = await http.get(
        Uri.parse(
            '$baseURL/sendPackage/gettemPackageByClientId/${user.id}/pending'),
        headers: authHeader());
    if (response.statusCode == 200) {
      pendingPackages.value = (jsonDecode(response.body) as List)
          .map((item) => DeliveryItem.fromJson(item))
          .toList();
    }
    print('pendingPackages.value ${pendingPackages.value}');

    isLoadPending.value = false;
    update();
  }

  Future getDeliveryItemsByDelivered() async {
    print('got to the getDeliveryItemsByDelivered');

    isLoadDelivered.value = true;
    update();
    User? user = UserController.instance.user.value;
    final response = await http.get(
        Uri.parse(
            '$baseURL/sendPackage/gettemPackageByClientId/${user.id}/completed'),
        headers: authHeader());
    if (response.statusCode == 200) {
      deliveredPackages.value = (jsonDecode(response.body) as List)
          .map((item) => DeliveryItem.fromJson(item))
          .toList();
    }
    print('deliveredPackages.value ${deliveredPackages.value}');
    isLoadDelivered.value = false;
    update();
  }

  Future<void> getPackageCategory() async {
    isLoad.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse(
          '${Api.baseUrl}${Api.getPackageCategory}?start=0&end=20',
        ),
        headers: authHeader(),
      );

      if (response.statusCode == 200) {
        final dynamic decodedBody = jsonDecode(response.body);

        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('items')) {
          consoleLog(decodedBody.toString());

          final List<dynamic> items = decodedBody['items'];

          // Map the items to ItemCategory and update the observable list
          packageCategory.value =
              items.map((item) => ItemCategory.fromJson(item)).toList();
          isLoad.value = false;
          update();
        } else {
          throw Exception('Unexpected response format: $decodedBody');
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
    } catch (error) {
      consoleLog('Error in getPackageCategory: $error');
      ApiProcessorController.errorSnack(
        'Error in getting package category.\n ERROR: $error',
      );
    } finally {
      isLoad.value = false;
      update();
    }
  }

  Future<void> getPackageWeight() async {
    isLoad.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}${Api.getPackageWeight}?start=0&end=20'),
        headers: authHeader(),
      );

      if (response.statusCode == 200) {
        final dynamic decodedBody = jsonDecode(response.body);

        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('items')) {
          consoleLog(decodedBody.toString());

          final List<dynamic> items = decodedBody['items'];

          // Map the items to ItemWeight and update the observable list
          packageWeight.value =
              items.map((item) => ItemWeight.fromJson(item)).toList();
          isLoad.value = false;
          update();
        } else {
          throw Exception('Unexpected response format: $decodedBody');
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
    } catch (error) {
      consoleLog('Error in getPackageWeight: $error');
      ApiProcessorController.errorSnack(
          'Error in getting package weight.\n ERROR: $error');
    } finally {
      isLoad.value = false;
      update();
    }
  }
}
