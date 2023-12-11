// ignore_for_file: use_build_context_synchronously

import 'package:benji/app/address/deliver_to.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/product/cart_product_container.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/components/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../product/product_detail_screen.dart';

class CartScreen extends StatefulWidget {
  final int index;
  const CartScreen({super.key, required this.index});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//==================================================== INITIAL STATE AND DISPOSE ==========================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  // will be passed into the select delivery address page
  List<Map<String, dynamic>>? formatOfOrder;

  Future<void> _handleRefresh() async {}

  //============================================================ ALL VARIABLES ===================================================================\\
  //==================================================== CONTROLLERS ======================================================\\
  final ScrollController _scrollController = ScrollController();

//==================================================== FUNCTIONS ==========================================================\\

  //================================== Navigation =======================================\\

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

  void _toCheckoutScreen(Map<String, dynamic> formatOfOrder) => Get.to(
        () => DeliverTo(formatOfOrder: formatOfOrder, index: widget.index),
        routeName: 'DeliverTo',
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
      child: GetBuilder<CartController>(
          // initState: (state) => CartController.instance.getCartProduct(),
          builder: (controller) {
        return Scaffold(
          appBar: MyAppBar(
            title: "Cart",
            elevation: 0.0,
            actions: const [],
            backgroundColor: kPrimaryColor,
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: controller.cartProducts.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: MyElevatedButton(
                      isLoading: controller.isLoad.value,
                      onPressed: () => _toCheckoutScreen(
                          controller.formatOfOrder[widget.index]),
                      title:
                          "Checkout (₦ ${formattedText(controller.subTotal.value[widget.index])})",
                    ),
                  ),
          ),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: controller.isLoad.value && controller.cartProducts.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  )
                : Scrollbar(
                    controller: _scrollController,
                    radius: const Radius.circular(10),
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: controller.cartProducts.isEmpty
                        ? const EmptyCard()
                        : ListView(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Text(
                                "Cart Summary".toUpperCase(),
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kSizedBox,
                              Container(
                                width: media.width,
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                decoration: ShapeDecoration(
                                  color: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0F000000),
                                      blurRadius: 24,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Subtotal",
                                      style: TextStyle(
                                        color: kTextBlackColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "₦ ${formattedText(controller.subTotal.value[widget.index])}",
                                      style: const TextStyle(
                                        color: kTextBlackColor,
                                        fontFamily: 'sen',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kSizedBox,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Cart".toUpperCase(),
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "(",
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: controller
                                          .cartProducts[widget.index].length
                                          .toString(),
                                      style: const TextStyle(
                                        color: kTextBlackColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ")",
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kSizedBox,
                              LayoutGrid(
                                rowGap: kDefaultPadding / 2,
                                columnGap: kDefaultPadding / 2,
                                columnSizes: breakPointDynamic(
                                    media.width,
                                    [1.fr],
                                    [1.fr, 1.fr],
                                    [1.fr, 1.fr, 1.fr],
                                    [1.fr, 1.fr, 1.fr, 1.fr]),
                                rowSizes: controller.cartProducts.isEmpty
                                    ? [auto]
                                    : List.generate(
                                        controller.cartProducts.length,
                                        (index) => auto),
                                children:
                                    (controller.cartProducts[widget.index])
                                        .map(
                                          (item) => ProductCartContainer(
                                            decrementQuantity: () => controller
                                                .decrementQuantityForCartPage(
                                                    item, widget.index),
                                            incrementQuantity: () => controller
                                                .incrementQuantityForCartPage(
                                                    item, widget.index),
                                            product: item,
                                            onTap: () =>
                                                _toProductDetailScreen(item),
                                          ),
                                        )
                                        .toList(),
                              ),
                              const SizedBox(height: kDefaultPadding * 5),
                            ],
                          ),
                  ),
          ),
        );
      }),
    );
  }
}
