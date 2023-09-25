import 'package:benji_user/app/product/product_detail_screen.dart';
import 'package:benji_user/src/common_widgets/product/product_card.dart';
import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';
import '../../others/my_future_builder.dart';
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
          query = '';
        },
        icon: FaIcon(FontAwesomeIcons.xmark, color: kAccentColor),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    //==================================================== CONTROLLERS ===========================================================\\
    final scrollController = ScrollController();

    //======================== FUNCTIONS ======================\\
    //===================== Get Data ==========================\\
    Future<List<Product>> getData() async {
      if (query == '') {
        return [];
      }
      List<Product> product = await getProductsBySearching(query);
      return product;
    }

    //========================================================================\\
    double mediaWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: MyFutureBuilder(
        future: getData(),
        child: (data) {
          return data.isEmpty
              ? ListView(
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
                            "No product found",
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    LayoutGrid(
                      rowGap: kDefaultPadding/2,
                      columnGap: kDefaultPadding/2,
                      columnSizes: breakPointDynamic(
                          mediaWidth,
                          [1.fr],
                          [1.fr, 1.fr],
                          [1.fr, 1.fr, 1.fr], [1.fr, 1.fr, 1.fr, 1.fr]),
                      rowSizes: List.generate(data.length, (index) => auto),
                      children: (data
                              as List<Product>)
                          .map(
                            (item) => ProductCard(
                        product: item,
                        onTap: () => _toProductDetailScreenPage(item),
                      ),).toList(),
                              ),
                  ],
                ),
              );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: ListView(
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
                  "Search for a product",
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
}
