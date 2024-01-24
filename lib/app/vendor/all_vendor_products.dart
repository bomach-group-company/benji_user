import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/category_button.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/route_manager.dart';

import '../../src/components/others/empty.dart';
import '../../src/components/product/product_card.dart';
import '../../src/components/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/product/product.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
import '../product/product_detail_screen.dart';

class AllVendorProducts extends StatefulWidget {
  final VendorModel vendor;

  const AllVendorProducts({
    super.key,
    required this.vendor,
  });

  @override
  State<AllVendorProducts> createState() => _AllVendorProductsState();
}

class _AllVendorProductsState extends State<AllVendorProducts> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    checkIfShoppingLocation(context);
    productAndSubCategoryName =
        getVendorProductsAndSubCategoryName(widget.vendor.id)
          ..then((value) {
            try {
              activeCategory = value.keys.toList()[0];
            } catch (e) {
              activeCategory = '';
            }
          });
  }

  late Future<Map<String, List<Product>>> productAndSubCategoryName;
  String activeCategory = '';
  @override
  void dispose() {
    super.dispose();
  }
//==========================================================================================\\

  //=================================== LOGIC ====================================\\

  Future<void> _handleRefresh() async {
    setState(() {
      productAndSubCategoryName =
          getVendorProductsAndSubCategoryName(widget.vendor.id)
            ..then((value) {
              try {
                activeCategory = value.keys.toList()[0];
              } catch (e) {
                activeCategory = '';
              }
            });
    });
  }

  //=================================== CONTROLLERS ====================================\\
  final ScrollController _scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

//=================================================== FUNCTIONS =====================================================\\
  void validate() {
    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "Thank you for your feedback!",
      const Duration(seconds: 1),
    );

    Get.back();
  }

  //========================================================================\\

  //============================================= Navigation =======================================\\
  void _toProductDetailScreen(product) => Get.to(
        () => ProductDetailScreen(product: product),
        routeName: 'ProductDetailScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "All Products",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: productAndSubCategoryName,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kAccentColor,
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              itemCount: snapshot.data!.keys.toList().length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding:
                                    const EdgeInsets.all(kDefaultPadding / 2),
                                child: CategoryButton(
                                  onPressed: () async {
                                    setState(() {
                                      activeCategory =
                                          snapshot.data!.keys.toList()[index];
                                    });
                                  },
                                  title: snapshot.data!.keys.toList()[index],
                                  bgColor: activeCategory ==
                                          snapshot.data!.keys.toList()[index]
                                      ? kAccentColor
                                      : kDefaultCategoryBackgroundColor,
                                  categoryFontColor: activeCategory ==
                                          snapshot.data!.keys.toList()[index]
                                      ? kPrimaryColor
                                      : kTextGreyColor,
                                ),
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          snapshot.data!.isEmpty
                              ? const EmptyCard(
                                  showButton: false,
                                )
                              : LayoutGrid(
                                  rowGap: kDefaultPadding / 2,
                                  columnGap: kDefaultPadding / 2,
                                  columnSizes: breakPointDynamic(
                                      media.width,
                                      [1.fr],
                                      [1.fr, 1.fr],
                                      [1.fr, 1.fr, 1.fr],
                                      [1.fr, 1.fr, 1.fr, 1.fr]),
                                  rowSizes:
                                      snapshot.data![activeCategory]!.isEmpty
                                          ? [auto]
                                          : List.generate(
                                              snapshot.data![activeCategory]!
                                                  .length,
                                              (index) => auto),
                                  children: (snapshot.data![activeCategory]
                                          as List<Product>)
                                      .map(
                                        (item) => ProductCard(
                                          product: item,
                                          onTap: () =>
                                              _toProductDetailScreen(item),
                                        ),
                                      )
                                      .toList(),
                                ),
                          kSizedBox,
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
