import 'package:benji/frontend/store/category.dart';
import 'package:benji/frontend/store/product.dart';
import 'package:benji/src/frontend/widget/cards/product_card_lg.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showMyDialog(BuildContext context, Product data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return MyCardLg(
        navigateCategory: CategoryPage(
          activeSubCategory: data.subCategoryId,
          activeCategory: data.subCategoryId.category,
        ),
        navigate: ProductPage(product: data),
        close: () {
          Get.back();
        },
        product: data,
      );
    },
  );
}
