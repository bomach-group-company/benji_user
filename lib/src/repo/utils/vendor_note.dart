import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/user_cart.dart';

const vendornote = 'vendornote';

Future addNoteToProduct(Product product, String vendorNote) async {
  List<VendorInfo> allCart = getAllCartItem();

  for (var cart in allCart) {
    if (cart.vendorId == product.vendorId.vendorOwner.id) {
      for (var cartItems in cart.vendorData) {
        if (cartItems.productId == product.id) {
          cartItems.message = vendorNote;
          break;
        }
      }
    }
  }

  setAllCartItem(allCart);
}

Future removeNoteFromProduct(Product product) async {
  List<VendorInfo> allCart = getAllCartItem();

  for (var cart in allCart) {
    if (cart.vendorId == product.vendorId.vendorOwner.id) {
      for (var cartItems in cart.vendorData) {
        if (cartItems.productId == product.id) {
          cartItems.message = '';
          break;
        }
      }
    }
  }

  setAllCartItem(allCart);
}

String getSingleProductNote(Product product) {
  List<VendorInfo> allCart = getAllCartItem();

  for (var cart in allCart) {
    if (cart.vendorId == product.vendorId.vendorOwner.id) {
      for (var cartItems in cart.vendorData) {
        if (cartItems.productId == product.id) {
          return cartItems.message;
        }
      }
    }
  }

  return '';
}

Future<Map> getProductsNote(int index) async {
  List<VendorInfo> allCart = getAllCartItem();
  Map note = {};

  for (var cartItems in allCart[index].vendorData) {
    note[cartItems.productId] = cartItems.message;
  }

  return note;
}
