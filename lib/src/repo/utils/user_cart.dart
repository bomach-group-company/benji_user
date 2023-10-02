import 'dart:convert';

import 'package:benji_user/main.dart';
import 'package:benji_user/src/repo/models/product/product.dart';

const String cartname = 'userCart';

Future addToCart(String vendorId, String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  if (cart.containsKey(vendorId)) {
    if (cart[vendorId].containsKey(productId)) {
      cart[vendorId][productId] += 1;
    } else {
      cart[vendorId][productId] = 1;
    }
  } else {
    cart[vendorId] = {productId: 1};
  }

  prefs.setString(cartname, jsonEncode(cart));
}

Future<Map?> getCart() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  return cart.isEmpty ? null : cart;
}

Future<int> countCartItem() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  int total = 0;
  for (var vendorId in cart.keys) {
    for (var productId in cart[vendorId].keys) {
      total = total + (cart[vendorId][productId] as int);
    }
  }
  return total;
}

Future<int> countCartItemByProduct(String vendorId, String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  int total = 0;
  if (cart.containsKey(vendorId)) {
    if (cart[vendorId].containsKey(productId)) {
      total = cart[vendorId][productId];
    }
  }
  return total;
}

Future<String> countCartItemTo10() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  int total = 0;
  for (var vendorId in cart.keys) {
    for (var productId in cart[vendorId].keys) {
      total = total + (cart[vendorId][productId] as int);
      if (total > 10) {
        return '10+';
      }
    }
  }
  return '$total';
}

Future minusFromCart(String vendorId, String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  if (cart.containsKey(vendorId)) {
    if (cart[vendorId].containsKey(productId)) {
      if (cart[vendorId][productId] > 1) {
        cart[vendorId][productId] -= 1;
      } else {
        cart[vendorId].remove(productId);
        if (cart[vendorId].keys.length == 0) {
          cart.remove(vendorId);
        }
      }
    }
  }
  prefs.setString(cartname, jsonEncode(cart));
}

Future<Map<String, dynamic>> getCartProductId() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  Map<String, dynamic> res = {};
  for (var vendorId in cart.keys) {
    for (var productId in cart[vendorId].keys) {
      res[productId] = cart[vendorId][productId];
    }
  }
  return res;
}

Future<List<Product>> getCartProduct([Function(String)? whenError]) async {
  List<Product> res = [];
  Map product = await getCartProductId();
  for (String item in product.keys) {
    try {
      res.add(await getProductById(item));
    } catch (e) {
      if (whenError != null) {
        whenError(item);
      }
    }
  }
  return res;
}
