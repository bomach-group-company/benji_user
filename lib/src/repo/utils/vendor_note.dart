import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/user_cart.dart';

const vendornote = 'vendornote';

Future addNoteToProduct(Product product, String vendorNote) async {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          item.message = vendorNote;
          break;
        }
      }
      break;
    }
  }

  setAllCartItem(allCart);
}

Future removeNoteFromProduct(Product product) async {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          item.message = '';
          break;
        }
      }
      break;
    }
  }

  setAllCartItem(allCart);
}

String getSingleProductNote(Product product) {
  AllCartItem allCart = getAllCartItem();

  for (var cartItems in allCart.data) {
    if (cartItems.vendorId == product.vendorId.id) {
      for (var item in cartItems.productUser) {
        if (item.productId == product.id) {
          return item.message;
        }
      }
      break;
    }
  }

  return '';
}

Future<Map> getProductsNote() async {
  AllCartItem allCart = getAllCartItem();
  Map note = {};
  for (var cartItems in allCart.data) {
    for (var item in cartItems.productUser) {
      note[item.productId] = item.message;
    }
  }

  return note;
}
