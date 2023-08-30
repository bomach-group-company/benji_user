import 'package:benji_user/app/checkout/checkout_screen.dart';
import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:benji_user/src/common_widgets/snackbar/my_floating_snackbar.dart';
import 'package:benji_user/src/common_widgets/vendor/cart_product_container.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/utils/cart.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../src/providers/constants.dart';
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
    _getData();
  }

  List<Product>? _data;

  _getData() async {
    _subTotal = 0;
    List<Product> product = await getCartProduct(
      (data) => mySnackBar(
        context,
        kAccentColor,
        "Error!",
        "Item with id $data not found",
        Duration(
          seconds: 1,
        ),
      ),
    );
    Map<String, dynamic> cartItems = await getCart();

    for (Product item in product) {
      _subTotal += (item.price * cartItems[item.id]);
    }

    setState(() {
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
  ScrollController _scrollController = ScrollController();

//==================================================== FUNCTIONS ==========================================================\\

  void incrementQuantity(String id) async {
    await addToCart(id);
    if (_data != null) {
      Product product = _data!.firstWhere((element) => element.id == id);
      _subTotal += product.price;
    }
    setState(() {});
  }

  void decrementQuantity(String id) async {
    await removeFromCart(id);
    if (_data != null) {
      Product product = _data!.firstWhere((element) => element.id == id);
      _subTotal -= product.price;
    }
    _itemCount = await countItemCart();

    setState(() {});
  }

  //===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
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
        () => const CheckoutScreen(),
        routeName: 'CheckoutScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Cart",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: _itemCount == 0
              ? SizedBox()
              : MyElevatedButton(
                  onPressed: _toCheckoutScreen,
                  title: "Checkout (₦ ${formattedText(_subTotal)})",
                ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kSizedBox,
                    SpinKitChasingDots(color: kAccentColor),
                  ],
                )
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
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
                        width: mediaWidth,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
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
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "₦ ${formattedText(_subTotal)}",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontFamily: 'sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Text(
                        "Cart (${formattedText(_itemCount.toDouble())})"
                            .toUpperCase(),
                        style: TextStyle(
                          color: kTextGreyColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kSizedBox,
                      ListView.separated(
                        separatorBuilder: (context, index) => kHalfSizedBox,
                        itemCount: _data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ProductCartContainer(
                            decrementQuantity: () =>
                                decrementQuantity(_data![index].id),
                            incrementQuantity: () =>
                                incrementQuantity(_data![index].id),
                            product: _data![index],
                            onTap: () => _toProductDetailScreen(_data![index]),
                          );
                        },
                      ),
                      _data!.isEmpty ? EmptyCard() : SizedBox(),
                      SizedBox(height: kDefaultPadding * 4),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
