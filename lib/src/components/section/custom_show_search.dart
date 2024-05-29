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
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: buildSearchResults(context),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: query.length >= 2
          ? buildSearchResults(context)
          : ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/animations/search/frame_1.json",
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      kSizedBox,
                      Text(
                        "Enter your search query",
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  //
  // @override
  // void showResults(BuildContext context) {
  //   super.showResults(context);
  //   // buildSearchResults(context);
  // }
  //
  // @override
  // void showSuggestions(BuildContext context) {
  //   super.showSuggestions(context);
  // }

  //======================== FUNCTIONS ======================\\
  //===================== Get Data ==========================\\
  Future<List<Product>> getData() async {
    List<Product> product = await getProductsBySearching(query);
    // log('product model in search $product, length: ${product.length}');
    if (query.length >= 2) {
      return product;
    }
    return [];
  }

  final scrollController = ScrollController();

  Widget buildSearchResults(context) {
    var media = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animations/search/frame_2.json",
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Searching...",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Lottie.asset(
                  "assets/animations/error/frame_1.json",
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Text(
                    "An error occurred.",
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return snapshot.data.isEmpty
            ? Scrollbar(
                child: ListView(
                  shrinkWrap: true,
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
                                onTap: () => _toProductDetailScreenPage(item),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
