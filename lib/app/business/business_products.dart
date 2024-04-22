// ignore_for_file: invalid_use_of_protected_member

import 'package:benji/app/business/business_detail_screen.dart';
import 'package:benji/app/product/product_detail_screen.dart';
import 'package:benji/src/components/business/business_card.dart';
import 'package:benji/src/components/button/category_button.dart';
import 'package:benji/src/components/others/empty.dart';
import 'package:benji/src/components/product/product_card.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/controller/sub_category_controller.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';

class BusinessProducts extends StatefulWidget {
  final BusinessModel business;

  const BusinessProducts({
    super.key,
    required this.business,
  });

  @override
  State<BusinessProducts> createState() => _BusinessProductsState();
}

class _BusinessProductsState extends State<BusinessProducts> {
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    checkIfShoppingLocation(context);
  }

  late Future<Map<String, List<Product>>> productAndSubCategoryName;

//=================================== Navigation =====================================\\
  void _toBusinessDetailScreenPage(BusinessModel business) => Get.off(
        () => BusinessDetailScreen(business: business),
        routeName: 'BusinessDetailScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: false,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toProductDetailScreen(product) => Get.to(
        () => ProductDetailScreen(product: product),
        routeName: 'ProductDetailScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

//=================================== END =====================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: GetBuilder<SubCategoryController>(
                initState: (state) => SubCategoryController.instance
                    .getSubCategoryAllByVendor(widget.business.id.toString()),
                builder: (controller) {
                  if (controller.isLoadForAll.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.allSubcategoryByVendor.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: CategoryButton(
                        onPressed: () => controller.setSubCategory(
                            controller.allSubcategoryByVendor[index],
                            widget.business),
                        title: controller.allSubcategoryByVendor[index].name,
                        bgColor: controller.activeSubCategory.value.id ==
                                controller.allSubcategoryByVendor[index].id
                            ? kAccentColor
                            : kDefaultCategoryBackgroundColor,
                        categoryFontColor:
                            controller.activeSubCategory.value.id ==
                                    controller.allSubcategoryByVendor[index].id
                                ? kPrimaryColor
                                : kTextGreyColor,
                      ),
                    ),
                  );
                }),
          ),
          kSizedBox,
          GetBuilder<ProductController>(builder: (controller) {
            if (controller.isLoadVendor.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              );
            }
            if (controller.vendorProducts.isEmpty &&
                controller.hasHitLoadToVendor.value) {
              return const EmptyCard(
                emptyCardMessage: 'There are no products available right now',
              );
            }
            return LayoutGrid(
              rowGap: kDefaultPadding / 2,
              columnGap: kDefaultPadding / 2,
              columnSizes: breakPointDynamic(media.width, [1.fr], [1.fr, 1.fr],
                  [1.fr, 1.fr, 1.fr], [1.fr, 1.fr, 1.fr, 1.fr]),
              rowSizes: controller.vendorProducts.isEmpty
                  ? [auto]
                  : List.generate(
                      controller.vendorProducts.length, (index) => auto),
              children: (controller.vendorProducts)
                  .map(
                    (item) => ProductCard(
                      product: item,
                      onTap: () => _toProductDetailScreen(item),
                    ),
                  )
                  .toList(),
            );
          }),
          kSizedBox,
          const Text(
            "Similar vendors",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(height: kDefaultPadding, color: kGreyColor1),
          kSizedBox,
          GetBuilder<VendorController>(
              initState: (state) => VendorController.instance
                  .getSimilarVendors(widget.business.id),
              builder: (controller) {
                if (controller.loadSimilarVendor.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  );
                }
                List<BusinessModel> vendorList =
                    controller.similarVendors.value;

                return SizedBox(
                  height: 250,
                  width: media.width,
                  child: ListView.separated(
                    itemCount: controller.similarVendors.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        deviceType(media.width) > 2
                            ? kWidthSizedBox
                            : kHalfWidthSizedBox,
                    itemBuilder: (context, index) => InkWell(
                      child: SizedBox(
                        width: 200,
                        child: BusinessCard(
                          business: vendorList[index],
                          removeDistance: false,
                          onTap: () {
                            _toBusinessDetailScreenPage(vendorList[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
          kSizedBox,
        ],
      ),
    );
  }
}
