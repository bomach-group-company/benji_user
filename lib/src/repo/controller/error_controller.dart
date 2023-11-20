// ignore_for_file: non_constant_identifier_names

import 'package:benji/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class ApiProcessorController extends GetxController {
  static Future<dynamic> errorState(data) async {
    try {
      if (data.statusCode == 200) {
        return data.body;
      }
      errorSnack("Something went wrong");
      return;
    } catch (e) {
      // errorSnack("Check your internet and try again");
      return;
    }
  }

  static void errorSnack(msg) {
    Get.showSnackbar(GetSnackBar(
      title: "ERROR",
      message: "$msg",
      backgroundColor: kAccentColor,
      duration: const Duration(seconds: 2),
    ));
  }

  static void successSnack(msg) {
    Get.showSnackbar(GetSnackBar(
      title: "Successful",
      message: "$msg",
      backgroundColor: kSuccessColor,
      duration: const Duration(seconds: 2),
    ));
  }
}
