import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/models/product/product.dart';

const String cartname = 'userCart';

bool productInCart(String productId) {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  return cart.containsKey(productId);
}

Future<void> clearCart() async {
  prefs.setString(cartname, '{}');
}

Future addToCart(String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  if (cart.containsKey(productId)) {
    cart[productId] += 1;
  } else {
    cart[productId] = 1;
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
  for (var productId in cart.keys) {
    total = total + (cart[productId] as int);
  }
  return total;
}

Future<int> countCartItemByProduct(String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  int total = 0;
  if (cart.containsKey(productId)) {
    total = cart[productId];
  }
  return total;
}

Future<String> countCartItemTo10() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  int total = 0;
  for (var productId in cart.keys) {
    total = total + (cart[productId] as int);
    if (total > 10) {
      return '10+';
    }
  }
  return '$total';
}

Future minusFromCart(String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  if (cart.containsKey(productId)) {
    if (cart[productId] > 1) {
      cart[productId] -= 1;
    } else {
      cart.remove(productId);
    }
  }
  prefs.setString(cartname, jsonEncode(cart));
}

Future removeFromCart(String productId) async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  if (cart.containsKey(productId)) {
    cart.remove(productId);
  }
  prefs.setString(cartname, jsonEncode(cart));
}

Future<Map<String, dynamic>> getCartProductId() async {
  Map cart = jsonDecode(prefs.getString(cartname) ?? '{}');
  Map<String, dynamic> res = {};
  for (var productId in cart.keys) {
    res[productId] = cart[productId];
  }
  return res;
}

Future<Map> getCartProduct([Function(String)? whenError]) async {
  List<Product> res = [];
  List<Map<String, dynamic>> formatOfOrder = [];
  Map product = await getCartProductId();
  for (String item in product.keys) {
    try {
      Product product = await getProductById(item);
      int quantity = await countCartItemByProduct(item);
      res.add(product);
      formatOfOrder.add({
        "product_id": product.id,
        "quantity": quantity,
        "pre_total": quantity * product.price,
        // "delivery_address": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
      });
    } catch (e) {
      if (whenError != null) {
        whenError(item);
      }
    }
  }
  return {'products': res, 'formatOfOrder': formatOfOrder};
}
