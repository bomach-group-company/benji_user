import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/cart.dart';
import '../../src/common_widgets/section/rate_product_dialog.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/repo/utils/cart.dart';
import '../../theme/colors.dart';
import '../checkout/checkout_screen.dart';
import 'report_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  //==================================================== INITIAL STATE ======================================================\\
  @override
  void initState() {
    super.initState();
    _isAddedToFavorites = false;
    checkCart();
  }

  //============================================================ ALL VARIABLES ===================================================================\\

  double _totalCost = 1200;
  double _itemPrice = 1200;
  double _productQuantity = 200;
  String cartCount = '1';
  String cartCountAll = '1';
//====================================================== BOOL VALUES ========================================================\\
  var _isAddedToFavorites;
  bool _isAddedToCart = false;
  bool isLoading = false;
  bool justInPage = true;

  //==================================================== CONTROLLERS ======================================================\\
  ScrollController _scrollController = ScrollController();

  //==================================================== FUNCTIONS ======================================================\\

  checkCart() async {
    String count = await countCart();
    String countAll = await countCart(all: true);

    setState(() {
      cartCount = count;
      cartCountAll = countAll;
      if (count != '0') {
        _isAddedToCart = true;
      } else {
        _isAddedToCart = false;
      }
    });
    if (_isAddedToCart == false && justInPage == false) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Item has been removed from cart.",
        Duration(
          seconds: 1,
        ),
      );
    }
    if (justInPage) {
      setState(() {
        justInPage = false;
      });
    }
  }

  //===================== Number format ==========================\\
  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    await checkCart();
  }

  //========================================================================\\

  void incrementQuantity() async {
    await addToCart('f4715bd5-80d5-4477-9167-393590d5aa30');
    await checkCart();
  }

  void decrementQuantity() async {
    await removeFromCart('f4715bd5-80d5-4477-9167-393590d5aa30');
    await checkCart();
  }

  void _addToFavorites() {
    setState(() {
      _isAddedToFavorites = !_isAddedToFavorites;
    });

    mySnackBar(
      context,
      kSuccessColor,
      "Success",
      _isAddedToFavorites
          ? "Product has been added to favorites"
          : "Product been removed from favorites",
      Duration(milliseconds: 500),
    );
  }

  Future<void> _cartAddFunction() async {
    await addToCart('f4715bd5-80d5-4477-9167-393590d5aa30');
    await checkCart();

    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "Item has been added to cart.",
      Duration(
        seconds: 1,
      ),
    );
  }

  //======================================= Navigation ==========================================\\

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

  //=================================== Show Popup Menu =====================================\\

//Show popup menu
  void showPopupMenu(BuildContext context) {
    const position = RelativeRect.fromLTRB(10, 60, 0, 0);

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        PopupMenuItem<String>(
          value: 'rate',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.solidStar, color: kStarColor),
              kWidthSizedBox,
              Text("Rate this product"),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'report',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.solidFlag, color: kAccentColor),
              kWidthSizedBox,
              Text("Report this product"),
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'rate':
            openRatingDialog(context);
            break;
          case 'report':
            Get.to(
              () => ReportProduct(),
              routeName: 'ReportProduct',
              duration: const Duration(milliseconds: 300),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              preventDuplicates: true,
              popGesture: true,
              transition: Transition.rightToLeft,
            );
            break;
        }
      }
    });
  }

//================================ Rating Dialog ======================================\\

  openRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding)),
          elevation: 50,
          child: RateProductDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Product Detail",
          elevation: 0.0,
          actions: [
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: cartCount == null ? null : _addToFavorites,
                      icon: FaIcon(
                        _isAddedToFavorites
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: kAccentColor,
                      ),
                    ),
                    CartCard()
                  ],
                )),
            IconButton(
              onPressed: () =>
                  cartCount == null ? null : showPopupMenu(context),
              icon: FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: kAccentColor,
              ),
            ),
          ],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  Center(child: SpinKitChasingDots(color: kAccentColor));
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  const Center(
                    child: Text("Please connect to the internet"),
                  );
                }
                // if (snapshot.connectionState == snapshot.requireData) {
                //   SpinKitChasingDots(color: kAccentColor);
                // }
                if (snapshot.connectionState == snapshot.error) {
                  const Center(
                    child: Text("Error, Please try again later"),
                  );
                }
                return cartCount == null
                    ? Center(child: SpinKitChasingDots(color: kAccentColor))
                    : Scrollbar(
                        controller: _scrollController,
                        radius: const Radius.circular(10),
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView(
                          physics: const ScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          children: [
                            SizedBox(
                              height: mediaHeight * 0.46,
                              child: Stack(
                                children: [
                                  Container(
                                    height: mediaHeight * 0.4,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/images/products/pasta.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: mediaWidth,
                              padding: EdgeInsets.all(kDefaultPadding / 2),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Name",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          kHalfSizedBox,
                                          SizedBox(
                                            width: mediaWidth / 2,
                                            child: Text(
                                              "Smokey Jollof Pasta",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Product price",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          kHalfSizedBox,
                                          SizedBox(
                                            width: mediaWidth / 2.5,
                                            child: Text(
                                              "₦ ${formattedText(_itemPrice)}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 22,
                                                fontFamily: 'sen',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  kSizedBox,
                                  SizedBox(
                                    width: mediaWidth / 3,
                                    height: 17,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Qty: ",
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                formattedText(_productQuantity),
                                            style: TextStyle(
                                              color: kTextBlackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  kSizedBox,
                                  Container(
                                    child: ReadMoreText(
                                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur fugiat, temporibus enim commodi iusto libero magni deleniti quod quam consequuntur! Commodi minima excepturi repudiandae velit hic maxime doloremque. Quaerat provident commodi consectetur veniam similique ad earum omnis ipsum saepe, voluptas, hic voluptates pariatur est explicabo fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam totam ratione voluptas quod exercitationem fuga. Possimus quis earum veniam quasi aliquam eligendi, placeat qui corporis! ",
                                      callback: (value) {},
                                      colorClickableText: kAccentColor,
                                      moreStyle: TextStyle(color: kAccentColor),
                                      lessStyle: TextStyle(color: kAccentColor),
                                      delimiter: "...",
                                      delimiterStyle:
                                          TextStyle(color: kAccentColor),
                                      trimMode: TrimMode.Line,
                                      trimLines: 4,
                                    ),
                                  ),
                                  kSizedBox,
                                  isLoading
                                      ? Column(
                                          children: [
                                            Center(
                                              child: SpinKitChasingDots(
                                                color: kAccentColor,
                                                duration:
                                                    const Duration(seconds: 1),
                                              ),
                                            ),
                                            kSizedBox,
                                          ],
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                            bottom: kDefaultPadding * 2,
                                          ),
                                          child: _isAddedToCart
                                              ? Positioned(
                                                  top: mediaHeight * 0.35,
                                                  left: mediaWidth /
                                                      5, // right: kDefaultPadding,
                                                  right: mediaWidth /
                                                      5, // right: kDefaultPadding,
                                                  child: Container(
                                                    width: mediaWidth,
                                                    height: 70,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFFAFAFA),
                                                      shadows: [
                                                        BoxShadow(
                                                          color: kBlackColor
                                                              .withOpacity(0.1),
                                                          blurRadius: 5,
                                                          spreadRadius: 2,
                                                          blurStyle:
                                                              BlurStyle.normal,
                                                        ),
                                                      ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(19),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            decrementQuantity();
                                                          },
                                                          splashRadius: 50,
                                                          icon: Icon(
                                                            Icons
                                                                .remove_rounded,
                                                            color: kBlackColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: kAccentColor,
                                                            shape: OvalBorder(),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        kDefaultPadding /
                                                                            2),
                                                            child: Center(
                                                              child: Text(
                                                                '$cartCountAll',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kTextWhiteColor,
                                                                  fontSize: 32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            incrementQuantity();
                                                          },
                                                          splashRadius: 50,
                                                          icon: Icon(
                                                            Icons.add_rounded,
                                                            color: kAccentColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : MyElevatedButton(
                                                  onPressed: () {
                                                    _cartAddFunction();
                                                  },
                                                  title:
                                                      "Add to Cart (₦${formattedText(_totalCost)})",
                                                ),
                                        ),
                                  SizedBox(
                                    height: kDefaultPadding * 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
