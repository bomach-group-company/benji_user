import 'dart:convert';

import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> addToCart(String id, {int qty = 1}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map cart = jsonDecode(await prefs.getString('cart') ?? '{}');

  if (cart[id] != null) {
    cart[id] += qty;
    await prefs.setString('cart', jsonEncode(cart));
    return await countCart();
  }
  cart[id] = qty;
  await prefs.setString('cart', jsonEncode(cart));
  return await countCart();
}

Future<String> removeFromCart(String id, {bool removeAll = false}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map cart = jsonDecode(await prefs.getString('cart') ?? '{}');
  if (cart[id] != null) {
    if (cart[id] == 1 || removeAll) {
      cart.remove(id);
      await prefs.setString('cart', jsonEncode(cart));
      return await countCart();
    }
    cart[id] -= 1;

    await prefs.setString('cart', jsonEncode(cart));
    return await countCart();
  }
  return await countCart();
}

Future<Map?> getCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cart = prefs.getString('cart');
  if (cart == null) {
    return null;
  }
  return jsonDecode(cart);
}

Future<List<Product>> getCartProduct([Function(String)? whenError]) async {
  List<Product> res = [];
  Map? cart = await getCart();
  if (cart == null) {
    return res;
  }

  for (String item in cart.keys) {
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

Future<String> countCart({all = false}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map cart = jsonDecode(prefs.getString('cart') ?? '{}');
  int total = 0;
  for (int num in cart.values) {
    total = total + num;
  }
  if (all) {
    return total.toString();
  }
  return total <= 10 ? total.toString() : '10+';
}
