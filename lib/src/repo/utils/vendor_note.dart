import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/user_cart.dart';

const vendornote = 'vendornote';

Future addNoteToProduct(Product product, String vendorNote) async {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      cartItems.message = vendorNote;
      break;
    }
  }

  setAllCartItem(allCart);
}

Future removeNoteFromProduct(Product product) async {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      cartItems.message = '';
      break;
    }
  }

  setAllCartItem(allCart);
}

String getSingleProductNote(Product product) {
  VendorInfo allCart = getAllCartItem();

  for (var cartItems in allCart.vendorData) {
    if (cartItems.productId == product.id) {
      return cartItems.message;
    }
  }

  return '';
}

Future<Map> getProductsNote() async {
  VendorInfo allCart = getAllCartItem();
  Map note = {};
  for (var cartItems in allCart.vendorData) {
    note[cartItems.productId] = cartItems.message;
  }

  return note;
}
