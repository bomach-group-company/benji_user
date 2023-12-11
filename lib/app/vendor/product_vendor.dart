import 'dart:math';

import 'package:benji/app/product/product_detail_screen.dart';
import 'package:benji/app/vendor/all_vendor_products.dart';
import 'package:benji/app/vendor/vendor_details.dart';
import 'package:benji/src/components/button/category_button.dart';
import 'package:benji/src/components/vendor/vendors_card.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/components/others/empty.dart';
import '../../src/components/product/product_card.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';

class ProductVendor extends StatefulWidget {
  final VendorModel vendor;
  const ProductVendor({
    super.key,
    required this.vendor,
  });

  @override
  State<ProductVendor> createState() => _ProductVendorState();
}

class _ProductVendorState extends State<ProductVendor> {
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    productAndSubCategoryName =
        getVendorProductsAndSubCategoryName(widget.vendor.id)
          ..then((value) {
            try {
              activeCategory = value.keys.toList()[0];
            } catch (e) {
              activeCategory = '';
            }
          });
  }

  late Future<Map<String, List<Product>>> productAndSubCategoryName;
  String activeCategory = '';

  // _getData() async {
  //   Map<String, List<Product>> productAndSubCategoryName =
  //       await getVendorProductsAndSubCategoryName(widget.vendor.id);
  //   try {
  //     activeCategory = productAndSubCategoryName.keys.toList()[0];
  //     // ignore: empty_catches
  //   } catch (e) {}

  //   setState(() {
  //     snapshot.data = productAndSubCategoryName;
  //   });
  // }

//=================================== Navigation =====================================\\
  void _toVendorDetailPage(VendorModel vendor) => Get.off(
        () => VendorDetails(vendor: vendor),
        routeName: 'VendorDetails',
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

  void _viewProducts() => Get.to(
        () => AllVendorProducts(vendor: widget.vendor),
        routeName: 'AllVendorProducts',
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
        children: [
          FutureBuilder(
            future: productAndSubCategoryName,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        itemCount: snapshot.data!.keys.toList().length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          child: CategoryButton(
                            onPressed: () async {
                              setState(() {
                                activeCategory =
                                    snapshot.data!.keys.toList()[index];
                              });
                            },
                            title: snapshot.data!.keys.toList()[index],
                            bgColor: activeCategory ==
                                    snapshot.data!.keys.toList()[index]
                                ? kAccentColor
                                : kDefaultCategoryBackgroundColor,
                            categoryFontColor: activeCategory ==
                                    snapshot.data!.keys.toList()[index]
                                ? kPrimaryColor
                                : kTextGreyColor,
                          ),
                        ),
                      ),
                    ),
                    kHalfSizedBox,
                    snapshot.data!.isEmpty
                        ? const EmptyCard(
                            removeButton: true,
                          )
                        : LayoutGrid(
                            rowGap: kDefaultPadding / 2,
                            columnGap: kDefaultPadding / 2,
                            columnSizes: breakPointDynamic(
                                media.width,
                                [1.fr],
                                [1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr, 1.fr]),
                            rowSizes: snapshot.data![activeCategory]!.isEmpty
                                ? [auto]
                                : List.generate(
                                    snapshot.data![activeCategory]!.length,
                                    (index) => auto),
                            children: (snapshot.data![activeCategory]
                                    as List<Product>)
                                .map(
                                  (item) => ProductCard(
                                    product: item,
                                    onTap: () => _toProductDetailScreen(item),
                                  ),
                                )
                                .toList(),
                          ),
                    kHalfSizedBox,
                  ],
                ),
              );
            },
          ),
          kSizedBox,
          GetBuilder<VendorController>(
              initState: (state) => VendorController.instance.getVendors(),
              builder: (controller) {
                if (controller.isLoad.value && controller.vendorList.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  );
                }
                return SizedBox(
                  height: 250,
                  width: media.width,
                  child: ListView.separated(
                    itemCount: min(controller.vendorList.length, 3),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        deviceType(media.width) > 2
                            ? kWidthSizedBox
                            : kHalfWidthSizedBox,
                    itemBuilder: (context, index) => InkWell(
                      child: SizedBox(
                        width: 200,
                        child: VendorsCard(
                          vendor: controller.vendorList[index],
                          removeDistance: false,
                          onTap: () {
                            _toVendorDetailPage(controller.vendorList[index]);
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
