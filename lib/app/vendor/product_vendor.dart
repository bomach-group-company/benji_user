import 'package:benji_user/app/product/product_detail_screen.dart';
import 'package:benji_user/app/vendor/all_vendor_products.dart';
import 'package:benji_user/src/common_widgets/button/category%20button.dart';
import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:benji_user/src/common_widgets/vendor/product_container.dart';
import 'package:benji_user/src/repo/models/category/sub_category.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';

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

  Map? _data;
  String activeCategory = '';

  _getData() async {
    await checkAuth(context);

    List<SubCategory> categories = await getSubCategories();
    List<Product> product = [];
    try {
      activeCategory = categories[0].id;
      product = await getProductsByVendorSubCategory(
          widget.vendor.id!, activeCategory);
    } catch (e) {}

    setState(() {
      _data = {'product': product, 'categories': categories};
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
    return _data == null
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
                    itemCount: _data!['categories'].length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: CategoryButton(
                        onPressed: () async {
                          setState(() {
                            activeCategory = _data!['categories'][index].id;
                            _data!['product'] = null;
                          });
                          List<Product> product =
                              await getProductsByVendorSubCategory(
                                  widget.vendor.id!, activeCategory);
                          setState(() {
                            _data!['product'] = product;
                          });
                        },
                        title: _data!['categories'][index].name,
                        bgColor:
                            activeCategory == _data!['categories'][index].id
                                ? kAccentColor
                                : kDefaultCategoryBackgroundColor,
                        categoryFontColor:
                            activeCategory == _data!['categories'][index].id
                                ? kPrimaryColor
                                : kTextGreyColor,
                      ),
                    ),
                  ),
                ),
                kHalfSizedBox,
                _data!['product'] == null
                    ? Center(
                        child: SpinKitChasingDots(
                          color: kAccentColor,
                          duration: const Duration(seconds: 1),
                        ),
                      )
                    : _data!['product'].isEmpty
                        ? EmptyCard(
                            removeButton: true,
                          )
                        : ListView.separated(
                            itemCount: _data!['product'].length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => kHalfSizedBox,
                            itemBuilder: (context, index) => ProductContainer(
                              product: _data!['product'][index],
                              onTap: () => _toProductDetailScreen(
                                  _data!['product'][index]),
                            ),
                          ),
                kSizedBox,
                TextButton(
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
