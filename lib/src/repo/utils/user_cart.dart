import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';

const String cartname = 'userCartItems';

AllCartItem getAllCartItem() {
  List cart = jsonDecode(prefs.getString(cartname) ?? '[]');
  AllCartItem allCart = AllCartItem.fromJson(cart);
  return allCart;
}

Future<void> setAllCartItem(AllCartItem allCart) async {
  prefs.setString(cartname, jsonEncode(allCart.toJson()));
}

bool productInCart(Product product) {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          return true;
        }
      }
    }
  }
  return false;
}

Future<void> clearCart() async {
  await prefs.setString(cartname, '[]');
  CartController.instance.getCartProduct();
}

Future addToCart(Product product) async {
  AllCartItem allCart = getAllCartItem();

  ProductUserData productUserData = ProductUserData.fromJson(
      {'product_id': product.id, 'pre_total': product.price});

  VendorInfo vendorInfo = VendorInfo.fromJson(
      {'vendor_id': product.vendorId.id, 'vendor_data': []});

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          item.quantity += 1;
          setAllCartItem(allCart);
          CartController.instance.getCartProduct();
          return;
        }
      }
      cartItems.productUser.add(productUserData);
      setAllCartItem(allCart);
      CartController.instance.getCartProduct();

      return;
    }
  }
  allCart.data.add(vendorInfo);
  allCart.data.last.productUser.add(productUserData);
  setAllCartItem(allCart);
  CartController.instance.getCartProduct();

  return;
}

List<Map<String, dynamic>> getCart() {
  AllCartItem allCart = getAllCartItem();

  return allCart.toJson();
}

int countCartItem() {
  AllCartItem allCart = getAllCartItem();
  int total = 0;
  for (var cartItem in allCart.data) {
    for (var _ in cartItem.productUser) {
      total += 1;
    }
  }
  return total;
}

int countCartItemByProduct(Product product) {
  AllCartItem allCart = getAllCartItem();
  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          return item.quantity;
        }
      }
    }
  }
  return 0;
}

String countCartItemTo10() {
  AllCartItem allCart = getAllCartItem();
  int total = 0;
  for (var cartItem in allCart.data) {
    for (var _ in cartItem.productUser) {
      total += 1;
      if (total > 10) {
        return '10+';
      }
    }
  }
  return '$total';
}

Future minusFromCart(Product product) async {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          item.quantity -= 1;
          if (item.quantity <= 0) {
            cartItems.productUser
                .removeWhere((element) => element.productId == item.productId);
          }
          setAllCartItem(allCart);
          CartController.instance.getCartProduct();

          return;
        }
      }
      if (cartItems.productUser.isEmpty) {
        allCart.data
            .removeWhere((element) => element.vendorId == cartItems.vendorId);
      }
      setAllCartItem(allCart);
      CartController.instance.getCartProduct();

      return;
    }
  }
  CartController.instance.getCartProduct();

  return;
}

Future removeFromCart(Product product) async {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          cartItems.productUser
              .removeWhere((element) => element.productId == item.productId);
          setAllCartItem(allCart);
          CartController.instance.getCartProduct();

          return;
        }
      }
      if (cartItems.productUser.isEmpty) {
        allCart.data
            .removeWhere((element) => element.vendorId == cartItems.vendorId);
      }
      setAllCartItem(allCart);
      CartController.instance.getCartProduct();

      return;
    }
  }
  CartController.instance.getCartProduct();

  return;
}

Map<String, ProductUserData> getCartProductId() {
  AllCartItem allCart = getAllCartItem();

  Map<String, ProductUserData> res = {};

  for (var cartItems in allCart.data) {
    for (var item in cartItems.productUser) {
      res[item.productId] = item;
    }
  }
  return res;
}

Future<Map<String, List>> getCartProduct([Function(String)? whenError]) async {
  AllCartItem allCart = getAllCartItem();
  List<Product> products = [];
  for (var cartItem in allCart.data) {
    for (var item in cartItem.productUser) {
      try {
        Product product = await getProductById(item.productId);
        products.add(product);
        item.preTotal = product.price * item.quantity;
      } catch (e) {
        cartItem.productUser
            .removeWhere((element) => element.productId == item.productId);
        if (whenError != null) {
          whenError(item.productId);
        }
      }
    }
  }
  return {'products': products, 'formatOfOrder': allCart.toJson()};
}
