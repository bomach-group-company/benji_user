import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/category.dart';
import 'package:benji/frontend/store/product.dart';
import 'package:benji/src/frontend/widget/cards/product_card_lg.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:benji/src/frontend/widget/section/hero.dart';
import 'package:benji/src/frontend/widget/text/fancy_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/model/all_product.dart';
import '../../src/frontend/model/category.dart';
import '../../src/frontend/model/product.dart';
import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/button.dart';
import '../../src/frontend/widget/cards/border_card.dart';
import '../../src/frontend/widget/cards/circle_card.dart';
import '../../src/frontend/widget/cards/image_card.dart';
import '../../src/frontend/widget/cards/product_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/end_to_end_row.dart';
import '../../src/frontend/widget/responsive/appbar/appbar.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showCard = false;

  CarouselController buttonCarouselController = CarouselController();

  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

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
    super.initState();
  }

  String productPopId = '';

  Future<Map<String, dynamic>> _getData() async {
    List<Category> categoriesData = await fetchCategories();
    AllProduct productsData = await fetchAllProduct(8);

    return {
      'productsData': productsData,
      'categoriesData': categoriesData,
      'trendingProduct': productsData.items,
      'todayProduct': productsData.items,
      'recommendedProduct': productsData.items
    };
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
        child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occured try refresh or contacting admin'),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              );
            } else {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          children: [
                            CarouselSlider(
                              carouselController: buttonCarouselController,
                              options: CarouselOptions(
                                autoPlay: true,
                                height: media.width > 1000
                                    ? media.height
                                    : media.width > 600
                                        ? media.width * 0.70
                                        : media.width * 0.90,
                                viewportFraction: 1.0,
                                padEnds: false,
                              ),
                              items: [
                                MyHero(
                                  image:
                                      'assets/frontend/assets/hero/slider-1.png',
                                  text1: 'Start Your Grocery Business',
                                  text2:
                                      'Stay Home & Delivered Your Daily Needs',
                                  buttonCarouselController:
                                      buttonCarouselController,
                                ),
                                MyHero(
                                  image:
                                      'assets/frontend/assets/hero/slider-2.png',
                                  text1:
                                      'Save up to 50% off on your first order',
                                  text2: 'Don\'t Miss Amazing Grocery Deals',
                                  buttonCarouselController:
                                      buttonCarouselController,
                                ),
                                MyHero(
                                  image:
                                      'assets/frontend/assets/hero/slider-3.png',
                                  text1: 'Save upto 30% off',
                                  text2: 'Buy Fresh Groceries & Organic food',
                                  buttonCarouselController:
                                      buttonCarouselController,
                                  hasExplore: false,
                                ),
                              ],
                            ),
                            kSizedBox,
                            kSizedBox,
                            kSizedBox,
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: breakPoint(
                                  media.width,
                                  25 - 13,
                                  100 - 15,
                                  100 - 15,
                                ),
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  // autoPlay: true,
                                  height: MediaQuery.of(context).size.width *
                                      breakPoint(media.width, 0.3, 0.22, 0.16),
                                  viewportFraction:
                                      breakPoint(media.width, 0.5, 0.5, 0.3333),
                                  padEnds: false,
                                ),
                                items: const [
                                  MyImageCard(
                                    image:
                                        'assets/frontend/assets/sale/banner-1.png',
                                  ),
                                  MyImageCard(
                                      image:
                                          'assets/frontend/assets/sale/banner-2.png'),
                                  MyImageCard(
                                      image:
                                          'assets/frontend/assets/sale/banner-3.png'),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      breakPoint(media.width, 25, 100, 100),
                                  vertical: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const EndToEndRow(
                                    widget1: MyFancyText(text: 'Categories'),
                                    widget2: MyOutlinedButton(
                                        navigate: CategoriesPage()),
                                  ),
                                  kSizedBox,
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      pageSnapping: false,
                                      // enableInfiniteScroll: false,
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      // autoPlay: true,
                                      // height: ,
                                      aspectRatio: breakPoint(
                                          media.width, 16 / 9, 3.5, 5.4),
                                      viewportFraction: breakPoint(
                                          media.width, 1 / 2, 1 / 4, 1 / 6),
                                      padEnds: false,
                                    ),
                                    items: (snapshot.data['categoriesData']
                                            as List<Category>)
                                        .map(
                                          (item) => MyClickable(
                                            navigate: CategoryPage(
                                              activeCategoriesId: item.id,
                                              activeCategories: item.name,
                                            ),
                                            child: MyCicleCard(
                                              image:
                                                  'assets/frontend/assets/circle_card/category-1.jpg',
                                              text: item.name,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  kSizedBox,
                                  const EndToEndRow(
                                    widget1: MyFancyText(text: 'Trending'),
                                    widget2: MyOutlinedButton(
                                        navigate: CategoriesPage()),
                                  ),
                                  kSizedBox,
                                  LayoutGrid(
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
                                      auto,
                                      auto,
                                      auto,
                                      auto
                                    ],
                                    children: (snapshot.data['trendingProduct']
                                            as List<Product>)
                                        .map(
                                          (item) => MyCard(
                                            product: item,
                                            navigateCategory: CategoryPage(
                                              activeSubCategories:
                                                  item.subCategory.name,
                                              activeSubCategoriesId:
                                                  item.subCategory.id,
                                              activeCategoriesId:
                                                  item.subCategory.category.id,
                                              activeCategories: item
                                                  .subCategory.category.name,
                                            ),
                                            navigate:
                                                ProductPage(product: item),
                                            action: () {
                                              setState(() {
                                                showCard = true;
                                                productPopId = item.id;
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 5,
                              child: Image.asset(
                                'assets/frontend/assets/banner/banner-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            kSizedBox,
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    breakPoint(media.width, 25, 100, 100),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: EndToEndRow(
                                      widget1:
                                          MyFancyText(text: 'Today\'s Special'),
                                      widget2: MyOutlinedButton(
                                          navigate: CategoriesPage()),
                                    ),
                                  ),
                                  kSizedBox,
                                  LayoutGrid(
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
                                      auto,
                                      auto,
                                      auto,
                                      auto
                                    ],
                                    children: (snapshot.data['todayProduct']
                                            as List<Product>)
                                        .map(
                                          (item) => MyCard(
                                            product: item,
                                            navigateCategory: CategoryPage(
                                              activeSubCategories:
                                                  item.subCategory.name,
                                              activeSubCategoriesId:
                                                  item.subCategory.id,
                                              activeCategoriesId:
                                                  item.subCategory.category.id,
                                              activeCategories: item
                                                  .subCategory.category.name,
                                            ),
                                            navigate:
                                                ProductPage(product: item),
                                            action: () {
                                              setState(() {
                                                showCard = true;
                                                productPopId = item.id;
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  // autoPlay: true,
                                  height: MediaQuery.of(context).size.width *
                                      breakPoint(media.width, 0.5, 0.44, 0.24),
                                  viewportFraction:
                                      breakPoint(media.width, 0.5, 0.5, 1 / 4),
                                  padEnds: false,
                                ),
                                items: const [
                                  MyImageCard(
                                    image:
                                        'assets/frontend/assets/mid_paragraph/banner-1.png',
                                  ),
                                  MyImageCard(
                                      image:
                                          'assets/frontend/assets/mid_paragraph/banner-2.png'),
                                  MyImageCard(
                                      image:
                                          'assets/frontend/assets/mid_paragraph/banner-3.png'),
                                  MyImageCard(
                                      image:
                                          'assets/frontend/assets/mid_paragraph/banner-3.png'),
                                ],
                              ),
                            ),
                            kSizedBox,
                            kSizedBox,
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    breakPoint(media.width, 25, 100, 100),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: EndToEndRow(
                                        widget1:
                                            MyFancyText(text: 'Recommended'),
                                        widget2: MyOutlinedButton(
                                            navigate: CategoriesPage()),
                                      )),
                                  kSizedBox,
                                  LayoutGrid(
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
                                      auto,
                                      auto,
                                      auto,
                                      auto
                                    ],
                                    children: (snapshot
                                                .data['recommendedProduct']
                                            as List<Product>)
                                        .map(
                                          (item) => MyCard(
                                            product: item,
                                            navigateCategory: CategoryPage(
                                              activeSubCategories:
                                                  item.subCategory.name,
                                              activeSubCategoriesId:
                                                  item.subCategory.id,
                                              activeCategoriesId:
                                                  item.subCategory.category.id,
                                              activeCategories: item
                                                  .subCategory.category.name,
                                            ),
                                            navigate:
                                                ProductPage(product: item),
                                            action: () {
                                              setState(() {
                                                showCard = true;
                                                productPopId = item.id;
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            kSizedBox,
                            AspectRatio(
                              aspectRatio: 5,
                              child: Image.asset(
                                'assets/frontend/assets/banner/banner-2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: breakPoint(media.width, 25, 50, 50),
                                vertical: 60,
                              ),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/frontend/assets/paragraph_bg/mobile_app_bg.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: LayoutGrid(
                                columnSizes: breakPointDynamic(
                                    media.width, [1.fr], [1.fr], [1.fr, 1.fr]),
                                rowSizes: const [auto, auto],
                                // rowGap: 40,
                                // columnGap: 24,
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/frontend/assets/device/mobile_app_1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        deviceType(media.width) > 2
                                            ? const SizedBox(
                                                height: kDefaultPadding * 2,
                                              )
                                            : kHalfSizedBox,
                                        const MyFancyText(
                                            text:
                                                'Single Groecry Ordering App'),
                                        kSizedBox,
                                        kSizedBox,
                                        const Text(
                                          'Experience the Revolutionised & user-friendly Top online Grocery Store ordering system to skyrocket Groceries sales.',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black54),
                                        ),
                                        kSizedBox,
                                        kHalfSizedBox,
                                        Row(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints.loose(
                                                const Size(100, 50),
                                              ),
                                              child: Image.asset(
                                                  'assets/frontend/assets/store/playstore.png'),
                                            ),
                                            kWidthSizedBox,
                                            Container(
                                              constraints: BoxConstraints.loose(
                                                const Size(100, 30),
                                              ),
                                              child: Image.asset(
                                                  'assets/frontend/assets/store/appstore.png'),
                                            ),
                                          ],
                                        ),
                                        kSizedBox,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            kSizedBox,
                            // Container(
                            //   margin: EdgeInsets.symmetric(
                            //       horizontal:
                            //           breakPoint(media.width, 25, 100, 100),
                            //       vertical: 50),
                            //   child: Column(
                            //     children: [
                            //       const Padding(
                            //         padding: EdgeInsets.all(15.0),
                            //         child: EndToEndRow(
                            //           widget1:
                            //               MyFancyText(text: 'Latest Blogs'),
                            //           widget2: MyOutlinedButton(
                            //               navigate: BlogsPage()),
                            //         ),
                            //       ),
                            //       kSizedBox,
                            //       kSizedBox,
                            //       LayoutGrid(
                            //         columnSizes: breakPointDynamic(
                            //             media.width,
                            //             [1.fr],
                            //             [1.fr, 1.fr],
                            //             [1.fr, 1.fr, 1.fr]),
                            //         rowSizes: const [auto, auto, auto],
                            //         children: const [
                            //           MyBlogCard(
                            //             date: '1 July 2022',
                            //             from: 'Admin',
                            //             title:
                            //                 'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                            //             image:
                            //                 'assets/frontend/assets/blog/blog-1.jpeg',
                            //             description:
                            //                 'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            //           ),
                            //           MyBlogCard(
                            //             date: '1 July 2022',
                            //             from: 'Admin',
                            //             title:
                            //                 'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                            //             image:
                            //                 'assets/frontend/assets/blog/blog-2.jpeg',
                            //             description:
                            //                 'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            //           ),
                            //           MyBlogCard(
                            //             date: '1 July 2022',
                            //             from: 'Admin',
                            //             title:
                            //                 'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                            //             image:
                            //                 'assets/frontend/assets/blog/blog-1.jpeg',
                            //             description:
                            //                 'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    breakPoint(media.width, 25, 120, 120),
                              ),
                              child: const Wrap(
                                spacing: 15,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  MyBorderCard(
                                    icon: Icons.car_crash,
                                    title: 'Fast Shopping',
                                    subtitle: 'Shop with easy',
                                  ),
                                  MyBorderCard(
                                    icon: Icons.pin_drop,
                                    title: 'Live Order Tracking',
                                    subtitle: 'Know where your package is at',
                                  ),
                                  MyBorderCard(
                                    icon: Icons.car_crash,
                                    title: 'Secure Shipping',
                                    subtitle: 'Your order is safe with us',
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            kSizedBox,
                            const Footer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Builder(builder: (context) {
                    Product data = (snapshot.data['productsData'] as AllProduct)
                        .items
                        .firstWhere(
                          (element) => element.id == productPopId,
                          orElse: () =>
                              (snapshot.data['productsData'] as AllProduct)
                                  .items
                                  .first,
                        );
                    return MyCardLg(
                      navigateCategory: CategoryPage(
                        activeSubCategories: data.subCategory.name,
                        activeSubCategoriesId: data.subCategory.id,
                        activeCategoriesId: data.subCategory.category.id,
                        activeCategories: data.subCategory.category.name,
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
              );
            }
          },
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
              ),
            ),
    );
  }
}
