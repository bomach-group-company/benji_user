import 'package:benji/frontend/store/product.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji/src/components/others/empty.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/model/all_product.dart';
import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/product_card.dart';
import '../../src/frontend/widget/cards/product_card_lg.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'category.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _showBackToTopButton = false;
  bool isLoading = false;

  // scroll controller
  late ScrollController _scrollController;

  late TextEditingController _searchController;

  bool showCard = false;
  String productPopId = '';

  @override
  void initState() {
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
    _searchController = TextEditingController();
    super.initState();
  }

  List<Product>? _getDataList;

  _getData(final String searchItem) async {
    if (searchItem != '') {
      AllProduct data = await fetchAllProductSearchByName(searchItem);

      setState(() {
        _getDataList = data.items;
        isLoading = false;
      });
    } else {
      setState(() {
        _getDataList = [];
        isLoading = false;
      });
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
      appBar: MyAppbar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    children: [
                      const MyBreadcrumb(
                        text: 'Search',
                        current: 'Search',
                        hasBeadcrumb: true,
                        back: 'home',
                      ),
                      kSizedBox,
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: breakPoint(media.width, 25, 50, 50)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        color: Colors.grey.shade300)
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      breakPoint(media.width, 15, 50, 50),
                                  vertical: 50),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _searchController,
                                      decoration: const InputDecoration(
                                          hintText: 'Product name',
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    label: const Text(''),
                                    style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.grey[200],
                                        foregroundColor: Colors.black,
                                        minimumSize: const Size(60, 60)),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _getData(
                                          _searchController.text.toString());
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            kSizedBox,
                            kHalfSizedBox,
                            Builder(builder: (context) {
                              if (isLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kAccentColor,
                                  ),
                                );
                              } else if (_getDataList == null ||
                                  _getDataList!.isEmpty) {
                                return const EmptyCard(
                                  showButton: false,
                                );
                              } else {
                                return LayoutGrid(
                                  columnSizes: breakPointDynamic(
                                      media.width,
                                      [1.fr],
                                      [1.fr, 1.fr],
                                      [1.fr, 1.fr, 1.fr, 1.fr]),
                                  rowSizes:
                                      List.filled(_getDataList!.length, auto),
                                  children: (_getDataList!)
                                      .map((item) => MyCard(
                                            product: item,
                                            navigateCategory: CategoryPage(
                                              activeSubCategory:
                                                  item.subCategoryId,
                                              activeCategory:
                                                  item.subCategoryId.category,
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
                              }
                            })
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
            Builder(builder: (context) {
              if (_getDataList == null || _getDataList!.isEmpty) {
                return const Text('');
              } else {
                Product data = (_getDataList!).firstWhere(
                  (element) => element.id == productPopId,
                  orElse: () => (_getDataList!).first,
                );
                return MyCardLg(
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
            }),
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
