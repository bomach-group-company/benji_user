import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';

const String cartname = 'userCart';

VendorInfo getAllCartItem() {
  Map<String, dynamic> cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  VendorInfo allCart = VendorInfo.fromJson(cart);
  return allCart;
}

Future<void> setAllCartItem(VendorInfo allCart) async {
  prefs.setString(cartname, jsonEncode(allCart.toJson()));
  CartController.instance.getCartProduct();
}

bool productInCart(Product product) {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      return true;
    }
  }
  return false;
}

Future<void> clearCart() async {
  await prefs.setString(cartname, '{}');
}

Future addToCart(Product product) async {
  VendorInfo allCart = getAllCartItem();

  VendorDataModel vendorDataData =
      VendorDataModel.fromJson({'product_id': product.id});

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      cartItems.quantity += 1;
      setAllCartItem(allCart);

      return;
    }
  }
  allCart.vendorData.add(vendorDataData);
  setAllCartItem(allCart);

  return;
}

Map<String, dynamic> getCart() {
  VendorInfo allCart = getAllCartItem();

  return allCart.toJson();
}

int countCartItem() {
  VendorInfo allCart = getAllCartItem();
  int total = 0;
  for (var _ in allCart.vendorData) {
    total += 1;
  }
  return total;
}

int countCartItemByProduct(Product product) {
  VendorInfo allCart = getAllCartItem();
  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      return cartItems.quantity;
    }
  }
  return 0;
}

String countCartItemTo10() {
  VendorInfo allCart = getAllCartItem();
  int total = 0;
  for (var _ in allCart.vendorData) {
    total += 1;
    if (total > 10) {
      return '10+';
    }
  }
  return '$total';
}

Future minusFromCart(Product product) async {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      cartItems.quantity -= 1;
      if (cartItems.quantity <= 0) {
        allCart.vendorData
            .removeWhere((element) => element.productId == cartItems.productId);
      }
      setAllCartItem(allCart);

      return;
    }
  }
}

Future removeFromCart(Product product) async {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      allCart.vendorData
          .removeWhere((element) => element.productId == cartItems.productId);
      setAllCartItem(allCart);

      return;
    }
  }
}

Map<String, VendorDataModel> getCartProductId() {
  VendorInfo allCart = getAllCartItem();

  Map<String, VendorDataModel> res = {};

  for (var cartItems in allCart.vendorData) {
    res[cartItems.productId] = cartItems;
  }
  return res;
}

Future<Map<String, dynamic>> getCartProduct(
    [Function(String)? whenError]) async {
  VendorInfo allCart = getAllCartItem();
  List<Product> products = [];
  for (var cartItem in allCart.vendorData) {
    try {
      Product product = await getProductById(cartItem.productId);
      products.add(product);
    } catch (e) {
      allCart.vendorData
          .removeWhere((element) => element.productId == cartItem.productId);
      if (whenError != null) {
        whenError(cartItem.productId);
      }
    }
  }
  return {'products': products, 'formatOfOrder': allCart.toJson()};
}
