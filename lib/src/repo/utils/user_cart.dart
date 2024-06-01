import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:get/get.dart';

const String cartname = 'userCartItemsStore';

List<VendorInfo> getAllCartItem() {
  String? cartAsString = prefs.getString(cartname);
  List<Map<String, dynamic>> carts = cartAsString == null
      ? []
      : List<Map<String, dynamic>>.from(jsonDecode(cartAsString));

  List<VendorInfo> allCart = [];
  for (var cart in carts) {
    allCart.add(VendorInfo.fromJson(cart));
  }
  return allCart;
}

int cartTotalNumber() {
  String? cartAsString = prefs.getString(cartname);
  List<Map<String, dynamic>> carts = cartAsString == null
      ? []
      : List<Map<String, dynamic>>.from(jsonDecode(cartAsString));

  int total = 0;
  for (var cart in carts) {
    final vendorCart = VendorInfo.fromJson(cart);
    total += vendorCart.vendorData.length;
  }
  return total;
}

Future<void> setAllCartItem(List<VendorInfo> allCart) async {
  List<Map<String, dynamic>> carts = [];
  for (var cart in allCart) {
    carts.add(cart.toJson());
  }
  prefs.setString(cartname, jsonEncode(carts));
  // CartController.instance.getCartProduct(); for now
}

bool productInCart(Product product) {
  List<VendorInfo> allCart = getAllCartItem();

  for (var cart in allCart) {
    for (var cartItems in cart.vendorData) {
      if (cartItems.productId == product.id) {
        return true;
      }
    }
  }
  return false;
}

Future<void> clearCart(int index) async {
  List<VendorInfo> allCart = getAllCartItem();
  allCart.removeAt(index);
  setAllCartItem(allCart);
}

Future addToCart(Product product) async {
  List<VendorInfo> allCart = getAllCartItem();

  VendorInfo vendorInfo = VendorInfo.fromJson({
    'vendor_data': [
      {'product_id': product.id}
    ],
    'business_id': product.vendorId.id
  });

  VendorDataModel vendorData =
      VendorDataModel.fromJson({'product_id': product.id});

  for (var i = 0; i < allCart.length; i++) {
    if (allCart[i].vendorId == product.vendorId.id) {
      for (var j = 0; j < allCart[i].vendorData.length; j++) {
        if (allCart[i].vendorData[j].productId == product.id) {
          allCart[i].vendorData[j].quantity += 1;
          setAllCartItem(allCart);
          return;
        }
      }
      allCart[i].vendorData.add(vendorData);
      setAllCartItem(allCart);
      return;
    }
  }

  allCart.add(vendorInfo);
  setAllCartItem(allCart);
  return;
}

Map<String, dynamic> getCart(int index) {
  List<VendorInfo> allCart = getAllCartItem();
  return allCart[index].toJson();
}

Future minusFromCart(Product product, {bool canClose = true}) async {
  List<VendorInfo> allCart = getAllCartItem();

  for (var i = 0; i < allCart.length; i++) {
    if (allCart[i].vendorId == product.vendorId.id) {
      for (var j = 0; j < allCart[i].vendorData.length; j++) {
        if (allCart[i].vendorData[j].productId == product.id) {
          allCart[i].vendorData[j].quantity -= 1;
          if (allCart[i].vendorData[j].quantity <= 0) {
            allCart[i].vendorData.removeAt(j);
          }
          if (allCart[i].vendorData.isEmpty) {
            allCart.removeAt(i);
            await setAllCartItem(allCart);
            if (canClose) {
              Get.close(1);
            }
            return;
          }
          setAllCartItem(allCart);
          return;
        }
      }
    }
  }
}

Future removeFromCart(Product product) async {
  List<VendorInfo> allCart = getAllCartItem();

  for (var i = 0; i < allCart.length; i++) {
    if (allCart[i].vendorId == product.vendorId.id) {
      for (var j = 0; j < allCart[i].vendorData.length; j++) {
        if (allCart[i].vendorData[j].productId == product.id) {
          allCart[i].vendorData.removeAt(j);
          if (allCart[i].vendorData.isEmpty) {
            allCart.removeAt(i);
            Get.close(1);
          }
          setAllCartItem(allCart);
          return;
        }
      }
    }
  }
}

int countCartItemByProduct(Product product) {
  int total = 0;
  List<VendorInfo> allCart = getAllCartItem();
  for (var cart in allCart) {
    if (cart.vendorId == product.vendorId.id) {
      for (var cartItems in cart.vendorData) {
        if (cartItems.productId == product.id) {
          return cartItems.quantity;
        }
      }
    }
  }
  return total;
}

Map<String, VendorDataModel> getCartProductId(int index) {
  List<VendorInfo> allCart = getAllCartItem();

  Map<String, VendorDataModel> res = {};

  for (var cartItems in allCart[index].vendorData) {
    res[cartItems.productId] = cartItems;
  }
  return res;
}
