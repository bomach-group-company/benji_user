import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/product.dart';
import 'package:benji/src/frontend/model/category.dart';
import 'package:benji/src/frontend/model/sub_category.dart';
import 'package:benji/src/frontend/widget/cards/product_card_lg.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji/src/others/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

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

  @override
  void initState() {
    activeSubCategoryId = widget.activeSubCategory?.id ?? '';
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
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
                                              removeButton: true,
                                            )
                                          : Column(
                                              children: [
                                                LayoutGrid(
                                                  columnSizes:
                                                      breakPointDynamic(
                                                          media.width, [
                                                    1.fr
                                                  ], [
                                                    1.fr,
                                                    1.fr
                                                  ], [
                                                    1.fr,
                                                    1.fr,
                                                    1.fr,
                                                    1.fr
                                                  ]),
                                                  rowSizes: (snapshot.data
                                                              as List<Product>)
                                                          .isEmpty
                                                      ? [auto]
                                                      : List.filled(
                                                          snapshot.data.length,
                                                          auto),
                                                  children: (snapshot.data
                                                          as List<Product>)
                                                      .map((item) => MyCard(
                                                            navigateCategory:
                                                                CategoryPage(
                                                              activeSubCategory:
                                                                  item.subCategory,
                                                              activeCategory: item
                                                                  .subCategory
                                                                  .category,
                                                            ),
                                                            navigate:
                                                                ProductPage(
                                                                    product:
                                                                        item),
                                                            action: () {
                                                              setState(() {
                                                                showCard = true;
                                                                productPopId =
                                                                    item.id;
                                                              });
                                                            },
                                                            product: item,
                                                          ))
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
                    navigateCategory: CategoryPage(
                      activeSubCategory: data.subCategory,
                      activeCategory: data.subCategory.category,
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
