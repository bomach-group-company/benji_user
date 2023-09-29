import 'package:benji_user/app/product/product_detail_screen.dart';
import 'package:benji_user/app/vendor/all_vendor_products.dart';
import 'package:benji_user/src/common_widgets/button/category_button.dart';
import '../../src/others/empty.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/product/product_card.dart';
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
    _getData();
  }

  Map<String, List<Product>>? _productAndSubCategoryName;
  String activeCategory = '';

  _getData() async {
    await checkAuth(context);

    Map<String, List<Product>> productAndSubCategoryName =
        await getVendorProductsAndSubCategoryName(widget.vendor.id);
    try {
      activeCategory = productAndSubCategoryName.keys.toList()[0];
      // ignore: empty_catches
    } catch (e) {}

    setState(() {
      _productAndSubCategoryName = productAndSubCategoryName;
    });
  }

//=================================== Navigation =====================================\\
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
    return _productAndSubCategoryName == null
        ? Center(
            child: SpinKitChasingDots(color: kAccentColor),
          )
        : Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: _productAndSubCategoryName!.keys.toList().length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: CategoryButton(
                        onPressed: () async {
                          setState(() {
                            activeCategory = _productAndSubCategoryName!.keys
                                .toList()[index];
                          });
                        },
                        title: _productAndSubCategoryName!.keys.toList()[index],
                        bgColor: activeCategory ==
                                _productAndSubCategoryName!.keys.toList()[index]
                            ? kAccentColor
                            : kDefaultCategoryBackgroundColor,
                        categoryFontColor: activeCategory ==
                                _productAndSubCategoryName!.keys.toList()[index]
                            ? kPrimaryColor
                            : kTextGreyColor,
                      ),
                    ),
                  ),
                ),
                kHalfSizedBox,
                _productAndSubCategoryName!.isEmpty
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
                        rowSizes:
                            _productAndSubCategoryName![activeCategory]!.isEmpty
                                ? [auto]
                                : List.generate(
                                    _productAndSubCategoryName![activeCategory]!
                                        .length,
                                    (index) => auto),
                        children: (_productAndSubCategoryName![activeCategory]
                                as List<Product>)
                            .map(
                              (item) => ProductCard(
                                product: item,
                                onTap: () => _toProductDetailScreen(item),
                              ),
                            )
                            .toList(),
                      ),
                kSizedBox,
                _productAndSubCategoryName!.isEmpty
                    ? const SizedBox()
                    : TextButton(
                        onPressed: _viewProducts,
                        child: Text(
                          "See all",
                          style: TextStyle(
                            color: kAccentColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                kHalfSizedBox,
              ],
            ),
          );
  }
}
