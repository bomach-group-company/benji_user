import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/models/cart_model/cart_model.dart';
import 'package:benji/src/repo/models/product/product.dart';

const String cartname = 'userCart';

List<VendorInfo> getAllCartItem() {
  List<Map<String, dynamic>> carts = List<Map<String, dynamic>>.from(
      jsonDecode(prefs.getString(cartname) ?? '[]'));

  List<VendorInfo> allCart = [];
  for (var cart in carts) {
    allCart.add(VendorInfo.fromJson(cart));
  }
  return allCart;
}

Future<void> setAllCartItem(List<VendorInfo> allCart) async {
  List<Map<String, dynamic>> carts = [];
  for (var cart in allCart) {
    carts.add(cart.toJson());
  }
  prefs.setString(cartname, jsonEncode(carts));
  CartController.instance.getCartProduct();
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
    'vendor_id': product.vendorId.id
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

Future minusFromCart(Product product) async {
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

// Future<Map<String, dynamic>> getCartProduct(int index,
//     [Function(String)? whenError]) async {
//   List<VendorInfo> allCart = getAllCartItem();
//   List<Product> products = [];
//   for (var cartItem in allCart[index].vendorData) {
//     try {
//       Product product = await getProductById(cartItem.productId);
//       products.add(product);
//     } catch (e) {
//       allCart[index]
//           .vendorData
//           .removeWhere((element) => element.productId == cartItem.productId);
//       if (whenError != null) {
//         whenError(cartItem.productId);
//       }
//     }
//   }
//   return {'products': products, 'formatOfOrder': allCart[index].toJson()};
// }
