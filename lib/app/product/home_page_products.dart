import 'package:benji/app/product/product_detail_screen.dart';
import 'package:benji/src/components/button/category_button.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/sub_category_controller.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/product/product_card.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class HomePageProducts extends StatefulWidget {
  final String activeCategory;
  const HomePageProducts({super.key, required this.activeCategory});

  @override
  State<HomePageProducts> createState() => _HomePageProductsState();
}

class _HomePageProductsState extends State<HomePageProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);

    SubCategoryController.instance.getSubCategory().then((value) {
      if (SubCategoryController.instance.subcategory.isNotEmpty) {
        ProductController.instance
            .setSubCategory(SubCategoryController.instance.subcategory[0]);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {}
  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Products",
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            radius: const Radius.circular(10),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              children: [
                GetBuilder<SubCategoryController>(builder: (controller) {
                  if (controller.isLoad.value &&
                      controller.subcategory.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 60,
                    child: ListView.builder(
                      itemCount: controller.subcategory.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Obx(
                          () => CategoryButton(
                            onPressed: () {
                              ProductController.instance.setSubCategory(
                                  controller.subcategory[index]);
                            },
                            title: controller.subcategory[index].name,
                            bgColor: ProductController.instance
                                        .selectedSubCategory.value.id ==
                                    controller.subcategory[index].id
                                ? kAccentColor
                                : kDefaultCategoryBackgroundColor,
                            categoryFontColor: ProductController.instance
                                        .selectedSubCategory.value.id ==
                                    controller.subcategory[index].id
                                ? kPrimaryColor
                                : kTextGreyColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                kSizedBox,
                GetBuilder<ProductController>(builder: (controller) {
                  if (controller.isLoad.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    );
                  }
                  return LayoutGrid(
                    rowGap: kDefaultPadding / 2,
                    columnGap: kDefaultPadding / 2,
                    columnSizes: breakPointDynamic(
                        media.width,
                        [1.fr],
                        [1.fr, 1.fr],
                        [1.fr, 1.fr, 1.fr],
                        [1.fr, 1.fr, 1.fr, 1.fr]),
                    rowSizes: controller.productsBySubCategory.isEmpty
                        ? [auto]
                        : List.generate(controller.productsBySubCategory.length,
                            (index) => auto),
                    children: (controller.productsBySubCategory)
                        .map(
                          (item) => ProductCard(
                            onTap: () {
                              Get.to(
                                () => ProductDetailScreen(product: item),
                                routeName: 'ProductDetailScreen',
                                duration: const Duration(milliseconds: 300),
                                fullscreenDialog: true,
                                curve: Curves.easeIn,
                                preventDuplicates: true,
                                popGesture: true,
                                transition: Transition.rightToLeft,
                              );
                            },
                            product: item,
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
