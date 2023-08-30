import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/src/repo/utils/help_instance.dart';

Future<String> addToCart(String id, {int qty = 1}) async {
  return await addToInstance('cart', id, qty: 1);
}

Future<String> removeFromCart(String id, {bool removeAll = false}) async {
  return await removeFromInstance('cart', id, removeAll: removeAll);
}

Future<Map<String, dynamic>> getCart() async {
  return await getInstance('cart');
}

Future<List<Product>> getCartProduct([Function(String)? whenError]) async {
  return await getInstanceProduct('cart', whenError);
}

Future<String> countCart({all = false}) async {
  return await countInstance('cart', all: all);
}
