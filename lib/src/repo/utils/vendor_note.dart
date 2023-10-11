import 'dart:convert';

import 'package:benji/main.dart';
import 'package:benji/src/repo/utils/user_cart.dart';

const vendornote = 'vendornote';

Future addNoteToProduct(String productId, String vendorNote) async {
  Map note = jsonDecode(prefs.getString(vendornote) ?? '{}');
  if (!productInCart(productId)) {
    return;
  }
  note[productId] = vendorNote;

  prefs.setString(vendornote, jsonEncode(note));
}

Future removeNoteFromProduct(String productId) async {
  Map note = jsonDecode(prefs.getString(vendornote) ?? '{}');
  if (note.containsKey(productId)) {
    note.remove(productId);
  }
  prefs.setString(vendornote, jsonEncode(note));
}

String getSingleProductNote(String productId) {
  Map note = jsonDecode(prefs.getString(vendornote) ?? '{}');
  if (!productInCart(productId)) {
    if (note.containsKey(productId)) {
      note.remove(productId);
    }
    return '';
  }
  if (note.containsKey(productId)) {
    return note[productId];
  }
  return '';
}

Future<Map?> getProductsNote() async {
  Map note = jsonDecode(prefs.getString(vendornote) ?? '{}');
  return note.isEmpty ? null : note;
}
