// ignore_for_file: empty_catches

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/utils/favorite.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance {
    return Get.find<FavouriteController>();
  }

  var isLoad = false.obs;
  var favouriteProducts = <Product>[].obs;
  var favouriteVendors = <VendorModel>[].obs;

  Future getProduct() async {
    isLoad.value = true;
    update();
    List<Product> product = await getFavoriteProduct(
      (data) =>
          ApiProcessorController.errorSnack("Item with id $data not found"),
    );

    favouriteProducts.value = product;
    isLoad.value = false;

    update();
  }

  Future getVendor() async {
    isLoad.value = true;
    update();
    List<VendorModel> vendor = await getFavoriteVendor(
      (data) =>
          ApiProcessorController.errorSnack("Item with id $data not found"),
    );

    favouriteVendors.value = vendor;
    isLoad.value = false;

    update();
  }
}
