import 'package:benji/app/product/home_page_products.dart';
import 'package:benji/src/components/simple_item/category_item.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/providers/responsive_constant.dart';
import 'package:benji/src/repo/controller/sub_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/route_manager.dart';

class CategoryItemSheet extends StatelessWidget {
  final List<dynamic> category;
  final bool isShop;

  const CategoryItemSheet(
      {super.key, required this.category, this.isShop = true});

  void _toSeeProducts(
    var category, {
    String id = '',
  }) {
    SubCategoryController.instance.setCategory(category);
    Get.to(
      () => HomePageProducts(activeCategory: id),
      routeName: 'HomePageProducts',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: LayoutGrid(
            columnGap: 10,
            rowGap: 10,
            columnSizes: breakPointDynamic(
              media.width,
              List.filled(4, 1.fr),
              List.filled(4, 1.fr),
              List.filled(8, 1.fr),
              List.filled(8, 1.fr),
            ),
            rowSizes:
                category.isEmpty ? [auto] : List.filled(category.length, auto),
            children: List.generate(category.length, (index) => index).map(
              (item) {
                return CategoryItem(
                  isShop: isShop,
                  category: category[item],
                  nav: () =>
                      _toSeeProducts(category[item], id: category[item].id),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
