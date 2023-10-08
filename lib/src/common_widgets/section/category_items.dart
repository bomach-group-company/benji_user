import 'package:benji/app/product/home_page_products.dart';
import 'package:benji/src/common_widgets/simple_item/category_item.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/providers/responsive_constant.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/route_manager.dart';

class CategoryItemSheet extends StatelessWidget {
  final List<SubCategory> subCategory;
  const CategoryItemSheet({super.key, required this.subCategory});

  void _toSeeProducts({String id = ''}) => Get.to(
        () => HomePageProducts(activeSubCategory: id),
        routeName: 'HomePageProducts',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: LayoutGrid(
            columnGap: 10,
            rowGap: 10,
            columnSizes: breakPointDynamic(
              mediaWidth,
              List.filled(4, 1.fr),
              List.filled(4, 1.fr),
              List.filled(8, 1.fr),
              List.filled(8, 1.fr),
            ),
            rowSizes: subCategory.isEmpty
                ? [auto]
                : List.filled(subCategory.length, auto),
            children: List.generate(subCategory.length, (index) => index).map(
              (item) {
                return CategoryItem(
                  subSategory: subCategory[item],
                  nav: () => _toSeeProducts(id: subCategory[item].id),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
