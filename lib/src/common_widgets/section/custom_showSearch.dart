import 'package:benji_user/src/common_widgets/product/home_products_card.dart';
import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';
import '../../others/my_future_builder.dart';

class CustomSearchDelegate extends SearchDelegate {
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
    final _scrollController = ScrollController();

    //==================================================== FUNCTIONS ===========================================================\\
    //===================== Get Data ==========================\\
    Future<List<Product>> _getData() async {
      if (query == '') {
        return [];
      }
      List<Product> product = await getProductsBySearching(query);
      return product;
    }

    //========================================================================\\

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: MyFutureBuilder(
        future: _getData(),
        child: (data) {
          return data.isEmpty
              ? Center(
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
                )
              : Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    shrinkWrap: true,
                    itemCount: data.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 10, color: kGreyColor),
                    itemBuilder: (context, index) => HomeProductsCard(
                      product: data[index],
                    ),
                  ),
                );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
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
    );
  }
}
