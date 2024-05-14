import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/category.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/frontend/model/product.dart';
import 'package:benji/src/frontend/utils/navigate.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/show_modal.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/button.dart';
import '../../src/frontend/widget/cards/product_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/end_to_end_row.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/frontend/widget/text/fancy_text.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;
  // int? _selectedRadioValue;

  @override
  void initState() {
    // _selectedRadioValue = 1;
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

    related = fetchProductFilterByCategory(
        widget.product.subCategoryId.category.id, 1, 6);

    super.initState();
  }

  late Future<List<Product>> related;

  Future<void> cartAddFunction() async {
    await addToCart(widget.product);
    setState(() {});
  }

  Future<void> cartRemoveFunction() async {
    await removeFromCart(widget.product);
    setState(() {});
  }

  Future<bool> _cartCount() async {
    int count = countCartItemByProduct(widget.product);
    return count > 0;
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
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, media.height * 0.11),
        // ignore: prefer_const_constructors
        child: MyAppbar(hideSearch: false),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                children: [
                  kSizedBox,
                  kSizedBox,
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: breakPoint(media.width, 25, 50, 50),
                    ),
                    child: LayoutGrid(
                      columnSizes: breakPointDynamic(
                          media.width, [1.fr], [18.fr, 32.fr], [18.fr, 32.fr]),
                      rowSizes: const [
                        auto,
                        auto,
                      ],
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: breakPoint(media.width, 0, 20, 20),
                          ),
                          height: media.height * 0.5,
                          decoration: BoxDecoration(
                              color: kPageSkeletonColor,
                              // image: const DecorationImage(
                              //   image: AssetImage(
                              //       "assets/images/products/okra-soup.png"),
                              //   fit: BoxFit.contain,
                              // ),
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: MyImage(url: widget.product.productImage)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            deviceType(media.width) == 1
                                ? kSizedBox
                                : const SizedBox(),
                            Row(
                              children: [
                                Icon(
                                  Icons.spa,
                                  color: kAccentColor,
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: Text(
                                    widget.product.name,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            kHalfSizedBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyClickable(
                                    navigate: CategoryPage(
                                      activeSubCategory:
                                          widget.product.subCategoryId,
                                      activeCategory:
                                          widget.product.subCategoryId.category,
                                    ),
                                    child: Text(
                                      widget.product.subCategoryId.name,
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kSizedBox,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '₦${widget.product.price}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                  future: _cartCount(),
                                  initialData: false,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    return snapshot.data
                                        ? ElevatedButton(
                                            onPressed: toLoginPage,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kAccentColor,
                                              minimumSize: Size(
                                                  breakPoint(
                                                    media.width,
                                                    media.width * 0.43,
                                                    media.width * 0.27,
                                                    media.width * 0.28,
                                                  ),
                                                  50),
                                            ),
                                            child: const Text('REMOVE'),
                                          )
                                        : ElevatedButton(
                                            onPressed: toLoginPage,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kAccentColor,
                                              minimumSize: Size(
                                                  breakPoint(
                                                    media.width,
                                                    media.width * 0.43,
                                                    media.width * 0.27,
                                                    media.width * 0.28,
                                                  ),
                                                  50),
                                            ),
                                            child: const Text(
                                              'ADD TO CART',
                                              style: TextStyle(
                                                  color: kTextWhiteColor),
                                            ),
                                          );
                                  },
                                ),
                                const SizedBox()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  kSizedBox,
                  kSizedBox,
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: breakPoint(media.width, 25, 50, 50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        kSizedBox,
                        Text(
                          widget.product.description,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        kSizedBox,
                        kSizedBox,
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: EndToEndRow(
                                widget1: MyFancyText(text: 'Related'),
                                widget2: MyOutlinedButton(
                                    navigate: CategoriesPage()),
                              ),
                            ),
                            kSizedBox,
                            FutureBuilder(
                                future: related,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: kAccentColor,
                                      ),
                                    );
                                  }
                                  return LayoutGrid(
                                    columnSizes: breakPointDynamic(
                                        media.width,
                                        [1.fr],
                                        [1.fr, 1.fr],
                                        [1.fr, 1.fr, 1.fr, 1.fr]),
                                    rowSizes: const [
                                      auto,
                                      auto,
                                      auto,
                                      auto,
                                    ],
                                    children: (snapshot.data ?? [])
                                        .map((item) => MyCard(
                                              refresh: () {
                                                setState(() {});
                                              },
                                              product: item,
                                              navigateCategory: CategoryPage(
                                                activeCategory:
                                                    item.subCategoryId.category,
                                              ),
                                              navigate:
                                                  ProductPage(product: item),
                                              action: () {
                                                showMyDialog(context, item);
                                              },
                                            ))
                                        .toList(),
                                  );
                                }),
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
