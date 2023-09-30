import 'package:benji_user/app/product/product_detail_screen.dart';
import 'package:benji_user/src/common_widgets/button/category_button.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/models/address/address_model.dart';
import 'package:benji_user/src/repo/models/category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/product/product_card.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/product/product.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';

class HomePageProducts extends StatefulWidget {
  final String? activeSubCategory;
  const HomePageProducts({super.key, this.activeSubCategory});

  @override
  State<HomePageProducts> createState() => _HomePageProductsState();
}

class _HomePageProductsState extends State<HomePageProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    if (widget.activeSubCategory != null) {
      activeSubCategory = widget.activeSubCategory!;
    }
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Map? _data;
  String activeSubCategory = '';

  _getData() async {
    await checkAuth(context);
    String current = 'Select Address';
    try {
      current = (await getCurrentAddress()).streetAddress ?? current;
    } catch (e) {
      current = current;
    }

    List<Product> product = [];
    List<SubCategory> subCategory = await getSubCategories();
    SubCategory activeSub;
    if (activeSubCategory == '' && subCategory.isNotEmpty) {
      activeSub = subCategory[0];
      activeSubCategory = activeSub.id;
    } else {
      activeSub =
          subCategory.firstWhere((element) => element.id == activeSubCategory);
    }

    try {
      product = await getProductsBySubCategory(activeSub.id);
    } catch (e) {
      product = [];
    }
    setState(() {
      _data = {
        'subCategory': subCategory,
        'product': product,
      };
    });
  }
  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }
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
          toolbarHeight: kToolbarHeight,
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? SpinKitChasingDots(color: kAccentColor)
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          itemCount: _data!['subCategory'].length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.all(10),
                            child: CategoryButton(
                              onPressed: () {
                                setState(() {
                                  activeSubCategory =
                                      _data!['subCategory'][index].id;
                                  _data!['product'] = null;
                                  _getData();
                                });
                              },
                              title: _data!['subCategory'][index].name,
                              bgColor: activeSubCategory ==
                                      _data!['subCategory'][index].id
                                  ? kAccentColor
                                  : kDefaultCategoryBackgroundColor,
                              categoryFontColor: activeSubCategory ==
                                      _data!['subCategory'][index].id
                                  ? kPrimaryColor
                                  : kTextGreyColor,
                            ),
                          ),
                        ),
                      ),
                      kSizedBox,
                      _data!['product'] == null
                          ? Center(
                              child: SpinKitChasingDots(color: kAccentColor))
                          : _data!['product'].isEmpty
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
                                  rowSizes: _data!['product'].isEmpty
                                      ? [auto]
                                      : List.generate(_data!['product'].length,
                                          (index) => auto),
                                  children: (_data!['product'] as List<Product>)
                                      .map(
                                        (item) => ProductCard(
                                          onTap: () {
                                            Get.to(
                                              () => ProductDetailScreen(
                                                  product: item),
                                              routeName: 'ProductDetailScreen',
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              fullscreenDialog: true,
                                              curve: Curves.easeIn,
                                              preventDuplicates: true,
                                              popGesture: true,
                                              transition:
                                                  Transition.rightToLeft,
                                            );
                                          },
                                          product: item,
                                        ),
                                      )
                                      .toList(),
                                ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
