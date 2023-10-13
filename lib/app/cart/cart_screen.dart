import 'package:benji/app/address/deliver_to.dart';
import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji/src/common_widgets/product/cart_product_container.dart';
import 'package:benji/src/common_widgets/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/product/product.dart';
import '../product/product_detail_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//==================================================== INITIAL STATE AND DISPOSE ==========================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);

    _getData();
  }

  List<Product>? _data;
  // will be passed into the select delivery address page
  List<Map<String, dynamic>>? formatOfOrder;

  _getData() async {
    _subTotal = 0;
    Map allData = await getCartProduct(
      (data) => mySnackBar(
        context,
        kAccentColor,
        "Error!",
        "Item not found",
        const Duration(
          seconds: 1,
        ),
      ),
    );
    List<Product> product = allData['products'];
    Map<String, dynamic> cartItems = await getCartProductId();

    for (Product item in product) {
      _subTotal += (item.price * cartItems[item.id]);
    }

    setState(() {
      formatOfOrder = allData['formatOfOrder'];
      _data = product;
      _itemCount = _data!.length;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }

  //============================================================ ALL VARIABLES ===================================================================\\
  int _itemCount = 0;
  double _subTotal = 0;
  //==================================================== CONTROLLERS ======================================================\\
  final ScrollController _scrollController = ScrollController();

//==================================================== FUNCTIONS ==========================================================\\

  void incrementQuantity(Product product) async {
    await addToCart(product.id);
    if (_data != null) {
      _subTotal += product.price;
    }
    setState(() {});
  }

  void decrementQuantity(Product product) async {
    await minusFromCart(product.id);
    if (_data != null) {
      _subTotal -= product.price;
    }
    _itemCount = await countCartItem();

    setState(() {});
  }

  //===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

  //================================== Navigation =======================================\\
  _clearCart() async {
    await clearCart();
    mySnackBar(
      context,
      kSuccessColor,
      "Cart Cleared!",
      "Cart items removed",
      const Duration(
        seconds: 1,
      ),
    );
    setState(() {
      _data = null;
    });
    await _getData();
  }

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

  void _toCheckoutScreen() => Get.to(
        () => DeliverTo(formatOfOrder: formatOfOrder!),
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
      child: Scaffold(
        appBar: MyAppBar(
          title: "Cart",
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: _itemCount == 0 ? null : _clearCart,
              tooltip: "Clear cart",
              icon: FaIcon(
                FontAwesomeIcons.solidTrashCan,
                size: 20,
                color: _itemCount == 0 ? kLightGreyColor : kAccentColor,
              ),
            ),
          ],
          backgroundColor: kPrimaryColor,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: _itemCount == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: MyElevatedButton(
                    onPressed: _toCheckoutScreen,
                    title: "Checkout (₦ ${formattedText(_subTotal)})",
                  ),
                ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                  ),
                )
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subtotal",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "₦ ${formattedText(_subTotal)}",
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
                              text: formattedText(_itemCount.toDouble())
                                  .toUpperCase(),
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
                        rowSizes: _data!.isEmpty
                            ? [auto]
                            : List.generate(_data!.length, (index) => auto),
                        children: (_data as List<Product>)
                            .map(
                              (item) => ProductCartContainer(
                                decrementQuantity: () =>
                                    decrementQuantity(item),
                                incrementQuantity: () =>
                                    incrementQuantity(item),
                                product: item,
                                onTap: () => _toProductDetailScreen(item),
                              ),
                            )
                            .toList(),
                      ),
                      _data!.isEmpty ? const EmptyCard() : const SizedBox(),
                      const SizedBox(height: kDefaultPadding * 5),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
