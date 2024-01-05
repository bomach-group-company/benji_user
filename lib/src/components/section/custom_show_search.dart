import 'package:benji/app/product/product_detail_screen.dart';
import 'package:benji/src/components/product/product_card.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';
import '../../providers/responsive_constant.dart';

class CustomSearchDelegate extends SearchDelegate {
  void _toProductDetailScreenPage(product) {
    Get.to(
      () => ProductDetailScreen(product: product),
      routeName: 'ProductDetailScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
  }

  @override
  void showSuggestions(BuildContext context) {
    super.showSuggestions(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: FaIcon(FontAwesomeIcons.chevronLeft, color: kAccentColor),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: FaIcon(FontAwesomeIcons.xmark, color: kAccentColor),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults(context);
  }

  //======================== FUNCTIONS ======================\\
  //===================== Get Data ==========================\\
  Future<List<Product>> getData() async {
    List<Product> product = await getProductsBySearching(query);
    if (query.length >= 2) {
      return product;
    }
    return [];
  }

  final scrollController = ScrollController();

  Widget buildSearchResults(context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/animations/internet/frame_1.json",
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  kSizedBox,
                  Text(
                    "Searching for network...",
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/animations/internet/frame_1.json",
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  kSizedBox,
                  Text(
                    "An error occurred.\nERROR: ${snapshot.error}",
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            return snapshot.data.isEmpty
                ? Scrollbar(
                    child: ListView(
                      controller: scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                "assets/animations/empty/frame_3.json",
                                height: 300,
                                fit: BoxFit.contain,
                              ),
                              kSizedBox,
                              Text(
                                "There are no results that match the search query",
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        children: [
                          LayoutGrid(
                            rowGap: kDefaultPadding / 2,
                            columnGap: kDefaultPadding / 2,
                            columnSizes: breakPointDynamic(
                                media.width,
                                [1.fr],
                                [1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr],
                                [1.fr, 1.fr, 1.fr, 1.fr]),
                            rowSizes: snapshot.data.isEmpty
                                ? [auto]
                                : List.generate(
                                    snapshot.data.length, (index) => auto),
                            children: (snapshot.data as List<Product>)
                                .map(
                                  (item) => ProductCard(
                                    product: item,
                                    onTap: () =>
                                        _toProductDetailScreenPage(item),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
          }
          return Center(
            child: Column(
              children: [
                Lottie.asset(
                  "assets/animations/search/frame_2.json",
                  height: 300,
                  fit: BoxFit.contain,
                ),
                Text(
                  "Searching...",
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults(context);
  }
}
