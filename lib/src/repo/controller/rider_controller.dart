// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/services/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RiderController extends GetxController {
  static RiderController get instance {
    return Get.find<RiderController>();
  }

  var isLoad = false.obs;

  Future<http.Response> assignTaskToRider(
      String itemType, String itemId, String driver) async {
    isLoad.value = true;
    update();
    Map body = {
      'item_type': itemType,
      'item_id': itemId,
      'driver': driver,
    };
    final response = await http.post(
        Uri.parse('$baseURL/tasks/assignTaskToRider'),
        headers: authHeader(),
        body: body);
    isLoad.value = false;
    update();
    return response;
  }
}
