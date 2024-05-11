import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/product.dart';
import 'package:benji/src/components/others/empty.dart';
import 'package:benji/src/frontend/model/sub_category.dart';
import 'package:benji/src/frontend/widget/cards/product_card_lg.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/model/product.dart';
import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/product_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class CategoryPage extends StatefulWidget {
  final Category activeCategory;
  final SubCategory? activeSubCategory;
  const CategoryPage({
    super.key,
    required this.activeCategory,
    this.activeSubCategory,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;
  String activeSubCategoryId = '';

  bool showCard = false;

  String productPopId = '';

  int _crossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return 1; // Small screens, e.g., mobile phones
    } else if (MediaQuery.of(context).size.width < 900) {
      return 2; // Medium screens, e.g., tablets
    } else if (MediaQuery.of(context).size.width < 1200) {
      return 3; // Large screens, e.g., laptops
    } else {
      return 4; // Extra-large screens, e.g., desktops
    }
  }

  double calculateAspectRatio(double height, int by, int remove) {
    return ((MediaQuery.of(context).size.width / by) - remove) / height;
  }

  double _aspectRatio(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return calculateAspectRatio(
          500, 1, 10); // Small screens, e.g., mobile phones
    } else if (MediaQuery.of(context).size.width < 900) {
      return calculateAspectRatio(600, 2, 30); // Medium screens, e.g., tablets
    } else if (MediaQuery.of(context).size.width < 1200) {
      return calculateAspectRatio(500, 3, 20); // Large screens, e.g., laptops
    } else {
      return calculateAspectRatio(
          500, 4, 20); // Extra-large screens, e.g., desktops
    }
  }

  @override
  void initState() {
    activeSubCategoryId = widget.activeSubCategory?.id ?? '';
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 400 && _showBackToTopButton == false) {
          setState(() {
            _showBackToTopButton = true;
          });
        } else if (!(_scrollController.offset >= 400) &&
            _showBackToTopButton == true) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      });

    _subCategories = fetchSubCategoryFilterByCategory(widget.activeCategory.id);
    _getProducts();

    super.initState();
  }

  late Future<List<SubCategory>> _subCategories;
  late Future<List<Product>> _products;

  _getProducts() {
    if (activeSubCategoryId == '') {
      _products = fetchProductFilterByCategory(widget.activeCategory.id, 1, 13);
    } else {
      _products = fetchProductFilterBySubCategory(activeSubCategoryId, 1, 13);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      drawerScrimColor: kTransparentColor,
      backgroundColor: kPrimaryColor,
      // ignore: prefer_const_constructors
      appBar: MyAppbar(hideSearch: false),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    children: [
                      MyBreadcrumb(
                        text: widget.activeCategory.name,
                        current: widget.activeCategory.name,
                        hasBeadcrumb: true,
                        back: 'categories',
                        backNav: const CategoriesPage(),
                      ),
                      kSizedBox,
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: breakPoint(media.width, 25, 50, 50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future: _subCategories,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                        return Row(
                                          children: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                minimumSize: const Size(10, 50),
                                                backgroundColor: kAccentColor,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {},
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        debugPrint('sub cat ${snapshot.data}');
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                    Row(
                                                      children: [
                                                        OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                const Size(
                                                                    10, 50),
                                                            backgroundColor:
                                                                activeSubCategoryId ==
                                                                        ''
                                                                    ? kAccentColor
                                                                    : Colors
                                                                        .white,
                                                            foregroundColor:
                                                                activeSubCategoryId ==
                                                                        ''
                                                                    ? Colors
                                                                        .white
                                                                    : kAccentColor,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              activeSubCategoryId =
                                                                  '';
                                                              _getProducts();
                                                            });
                                                          },
                                                          child:
                                                              const Text('All'),
                                                        ),
                                                        kHalfWidthSizedBox,
                                                      ],
                                                    )
                                                  ] +
                                                  (snapshot.data
                                                          as List<SubCategory>)
                                                      .map((item) {
                                                    return Row(
                                                      children: [
                                                        OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                const Size(
                                                                    10, 50),
                                                            backgroundColor:
                                                                activeSubCategoryId ==
                                                                        item.id
                                                                    ? kAccentColor
                                                                    : Colors
                                                                        .white,
                                                            foregroundColor:
                                                                activeSubCategoryId ==
                                                                        item.id
                                                                    ? Colors
                                                                        .white
                                                                    : kAccentColor,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              activeSubCategoryId =
                                                                  item.id;
                                                              _getProducts();
                                                            });
                                                          },
                                                          child:
                                                              Text(item.name),
                                                        ),
                                                        kHalfWidthSizedBox,
                                                      ],
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                kSizedBox,
                                FutureBuilder(
                                  future: _products,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: kAccentColor,
                                        ),
                                      );
                                    } else {
                                      return snapshot.data.isEmpty
                                          ? const EmptyCard(
                                              showButton: false,
                                            )
                                          : Column(
                                              children: [
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  // Specify the number of columns in the grid
                                                  crossAxisCount:
                                                      _crossAxisCount(context),
                                                  crossAxisSpacing: 5.0,
                                                  mainAxisSpacing: 5.0,
                                                  childAspectRatio:
                                                      _aspectRatio(context),
                                                  children: (snapshot.data
                                                          as List<Product>)
                                                      .map(
                                                        (item) => MyCard(
                                                          refresh: () {
                                                            setState(() {});
                                                          },
                                                          product: item,
                                                          navigateCategory:
                                                              CategoryPage(
                                                            activeSubCategory:
                                                                item.subCategoryId,
                                                            activeCategory: item
                                                                .subCategoryId
                                                                .category,
                                                          ),
                                                          navigate: ProductPage(
                                                              product: item),
                                                          action: () {
                                                            setState(() {
                                                              showCard = true;
                                                              productPopId =
                                                                  item.id;
                                                            });
                                                          },
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ],
                                            );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      kSizedBox,
                      kSizedBox,
                      const Footer(),
                    ],
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Text('');
                } else {
                  Product data = (snapshot.data!).firstWhere(
                    (element) => element.id == productPopId,
                    orElse: () => (snapshot.data!).first,
                  );
                  return MyCardLg(
                    refresh: () {
                      setState(() {});
                    },
                    navigateCategory: CategoryPage(
                      activeSubCategory: data.subCategoryId,
                      activeCategory: data.subCategoryId.category,
                    ),
                    navigate: ProductPage(product: data),
                    visible: showCard,
                    close: () {
                      setState(() {
                        showCard = false;
                      });
                    },
                    product: data,
                  );
                }
              },
            ),
          ],
        ),
      ),
      endDrawer: const MyDrawer(),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(45, 45),
                  foregroundColor: kAccentColor,
                  side: BorderSide(color: kAccentColor)),
              onPressed: _scrollToTop,
              child: const Icon(
                Icons.arrow_upward,
                size: 20,
                // color: Colors.white,
              ),
            ),
    );
  }
}
