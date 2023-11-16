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
  var formatOfOrder = <Map<String, dynamic>>[].obs;

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
    AllCartItem allCart = getAllCartItem();
    List<Product> products = [];
    double total = 0.0;
    for (var cartItem in allCart.data) {
      for (var item in cartItem.productUser) {
        try {
          Product product = await getProductById(item.productId);
          products.add(product);
          item.preTotal = product.price * item.quantity;
          total += (product.price * item.quantity);
        } catch (e) {
          cartItem.productUser
              .removeWhere((element) => element.productId == item.productId);
          ApiProcessorController.errorSnack('Failed to load ${item.productId}');
        }
      }
    }
    isLoad.value = false;
    subTotal.value = total;
    cartProducts.value = products;
    formatOfOrder.value = allCart.toJson();
    update();
  }
}
