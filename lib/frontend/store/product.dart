import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/category.dart';
import 'package:benji/src/frontend/model/product.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/button.dart';
import '../../src/frontend/widget/cards/product_card.dart';
import '../../src/frontend/widget/cards/product_card_lg.dart';
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
  double price = 40.00;
  String productPopId = '';
  bool showCard = false;

  @override
  void initState() {
    // _selectedRadioValue = 1;
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

    related = fetchProductFilterByCategory(
        widget.product.subCategory.category.id, 1, 6);

    super.initState();
  }

  late Future<List<Product>> related;

  Future<void> _cartAddFunction() async {
    await addToCart(widget.product.id.toString());
    setState(() {});
  }

  Future<void> _cartRemoveFunction() async {
    await removeFromCart(widget.product.id.toString());
    setState(() {});
  }

  Future<bool> _cartCount() async {
    int count = await countCartItemByProduct(widget.product.id.toString());
    return count > 0;
  }

  // Future<Map<String, dynamic>> _getData() async {
  //   return {
  //     'product': widget.product,
  //     'related': await fetchAllProductFilterByCategory(
  //         widget.product.subCategory.category.id, 1, 6)
  //   };
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  // void _handleRadioValueChanged(int? value) {
  //   if (value != null) {
  //     setState(() {
  //       price = price == 40.00 ? 20.00 : 40.00;
  //       _selectedRadioValue = value;
  //     });
  //   }
  // }

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
                    kSizedBox,
                    kSizedBox,
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: breakPoint(media.width, 25, 50, 50),
                      ),
                      child: LayoutGrid(
                        columnSizes: breakPointDynamic(media.width, [1.fr],
                            [18.fr, 32.fr], [18.fr, 32.fr]),
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
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/products/okra-soup.png"),
                                  fit: BoxFit.contain,
                                ),
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MyClickable(
                                      navigate: CategoryPage(
                                        activeSubCategory:
                                            widget.product.subCategory,
                                        activeCategory:
                                            widget.product.subCategory.category,
                                      ),
                                      child: Text(
                                        widget.product.subCategory.name,
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
                                      '₦$price',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                    future: _cartCount(),
                                    initialData: false,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      return snapshot.data
                                          ? ElevatedButton(
                                              onPressed: _cartRemoveFunction,
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
                                              onPressed: _cartAddFunction,
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
                                              child: const Text('ADD TO CART'),
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
                                                product: item,
                                                navigateCategory: CategoryPage(
                                                  activeCategory:
                                                      item.subCategory.category,
                                                ),
                                                navigate:
                                                    ProductPage(product: item),
                                                action: () {
                                                  setState(() {
                                                    showCard = true;
                                                    productPopId = item.id;
                                                  });
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
          FutureBuilder(
              future: related,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                Product data = snapshot.data!.firstWhere(
                  (element) => element.id == productPopId,
                  orElse: () => snapshot.data!.first,
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
              }),
        ],
      )),
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
