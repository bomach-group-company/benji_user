// ignore_for_file: empty_catches

import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance {
    return Get.find<CartController>();
  }

  var subTotal = 0.0.obs;
  var isLoad = false.obs;
  var cartProducts = <Product>[].obs;
  var formatOfOrder = <String, dynamic>{}.obs;

  Future clearCartProduct() async {
    clearCart();
    update();
  }

  void incrementQuantityForCartPage(Product product) async {
    await addToCart(product);
    subTotal.value += product.price;
    update();
    getCartProduct();
  }

  void decrementQuantityForCartPage(Product product) async {
    await minusFromCart(product);
    subTotal.value -= product.price;
    update();
    getCartProduct();
  }

  Future getCartProduct() async {
    isLoad.value = true;
    update();
    VendorInfo allCart = getAllCartItem();
    List<Product> products = [];
    double total = 0.0;
    for (var cartItem in allCart.vendorData) {
      try {
        Product product = await getProductById(cartItem.productId);
        products.add(product);
        total += (product.price * cartItem.quantity);
      } catch (e) {
        allCart.vendorData
            .removeWhere((element) => element.productId == cartItem.productId);
        ApiProcessorController.errorSnack(
            'Failed to load ${cartItem.productId}');
      }
    }
    isLoad.value = false;
    subTotal.value = total;
    cartProducts.value = products;
    formatOfOrder.value = allCart.toJson();
    update();
  }
}
