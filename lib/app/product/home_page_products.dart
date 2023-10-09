import 'package:benji/app/product/product_detail_screen.dart';
import 'package:benji/src/common_widgets/button/category_button.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/product/product_card.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/product/product.dart';
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
    _products = Future(() => []);

    _subCategories = getSubCategoriesBycategory(widget.activeCategory)
      ..then((value) {
        if (value.isNotEmpty) {
          activeSubCategory = value[0].id;
          _products = getProductsBySubCategory(activeSubCategory);
        }
      });
  }

  late Future<List<SubCategory>> _subCategories;
  late Future<List<Product>> _products;
  late Future<List<Product>> _current;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Map? _data;
  String activeSubCategory = '';

  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    _products = Future(() => []);

    _subCategories = getSubCategoriesBycategory(widget.activeCategory)
      ..then((value) {
        if (value.isNotEmpty) {
          activeSubCategory = value[0].id;
          _products = getProductsBySubCategory(activeSubCategory);
        }
      });
    setState(() {});
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
              ? Center(child: CircularProgressIndicator(color: kAccentColor))
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
                      FutureBuilder(
                          future: _subCategories,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(
                                color: kAccentColor,
                              );
                            }
                            return SizedBox(
                              height: 60,
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CategoryButton(
                                    onPressed: () {
                                      setState(() {
                                        activeSubCategory =
                                            snapshot.data![index].id;
                                        _products = getProductsBySubCategory(
                                            activeSubCategory);
                                      });
                                    },
                                    title: snapshot.data![index].name,
                                    bgColor: activeSubCategory ==
                                            snapshot.data![index].id
                                        ? kAccentColor
                                        : kDefaultCategoryBackgroundColor,
                                    categoryFontColor: activeSubCategory ==
                                            snapshot.data![index].id
                                        ? kPrimaryColor
                                        : kTextGreyColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                      kSizedBox,
                      FutureBuilder(
                          future: _subCategories,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(
                                color: kAccentColor,
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const EmptyCard(
                                removeButton: true,
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
                              rowSizes: snapshot.data!.isEmpty
                                  ? [auto]
                                  : List.generate(
                                      snapshot.data!.length, (index) => auto),
                              children: (snapshot.data! as List<Product>)
                                  .map(
                                    (item) => ProductCard(
                                      onTap: () {
                                        Get.to(
                                          () => ProductDetailScreen(
                                              product: item),
                                          routeName: 'ProductDetailScreen',
                                          duration:
                                              const Duration(milliseconds: 300),
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
