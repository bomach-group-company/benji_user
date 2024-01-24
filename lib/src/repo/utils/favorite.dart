import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/controller/favourite_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';

String instanceNameProduct = 'favoriteProduct';
String instanceNameVendor = 'favoriteVendors';

//============================ PRODUCT ================================//

Future<bool> favoriteItP(String id) async {
  Map products = jsonDecode(prefs.getString(instanceNameProduct) ?? '{}');

  bool? res;
  bool val = products[id] == null || products[id] == false;
  if (val) {
    products[id] = val;
    res = true;
  } else {
    if (products[id] != null) {
      products.remove(id);
    }
    res = false;
  }

  bool isSet = await prefs.setString(instanceNameProduct, jsonEncode(products));
  if (isSet == false) {
    throw Exception('Error occured while tring to set favorite');
  }
  FavouriteController.instance.getProduct();

  return res;
}

Future<Map> getFavoriteP() async {
  Map products = jsonDecode(prefs.getString(instanceNameProduct) ?? '{}');
  return products;
}

Future<bool> getFavoritePSingle(String id) async {
  Map products = await getFavoriteP();

  return products[id] ?? false;
}

Future<List<Product>> getFavoriteProduct([Function(String)? whenError]) async {
  List<Product> res = [];
  Map favorities = await getFavoriteP();
  for (String item in favorities.keys) {
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

//================================ VENDOR =========================//
Future<bool> favoriteItV(String id) async {
  Map vendors = jsonDecode(prefs.getString(instanceNameVendor) ?? '{}');

  bool? res;
  bool val = vendors[id] == null || vendors[id] == false;
  if (val) {
    vendors[id] = val;
    res = true;
  } else {
    if (vendors[id] != null) {
      vendors.remove(id);
    }
    res = false;
  }

  bool isSet = await prefs.setString(instanceNameVendor, jsonEncode(vendors));
  if (isSet == false) {
    throw Exception('Error occured while tring to set favorite');
  }
  FavouriteController.instance.getVendor();
  return res;
}

Future<Map> getFavoriteV() async {
  Map vendors = jsonDecode(prefs.getString(instanceNameVendor) ?? '{}');
  return vendors;
}

Future<bool> getFavoriteVSingle(String id) async {
  Map vendors = await getFavoriteV();

  return vendors[id] ?? false;
}

Future<List<BusinessModel>> getFavoriteVendor(
    [Function(String)? whenError]) async {
  List<BusinessModel> res = [];
  Map favorities = await getFavoriteV();
  for (String item in favorities.keys) {
    try {
      res.add(await getVendorById(item));
    } catch (e) {
      if (whenError != null) {
        whenError(item);
      }
    }
  }
  return res;
}
