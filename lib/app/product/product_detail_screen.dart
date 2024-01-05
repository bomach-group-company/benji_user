// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:benji/app/vendor/vendor_details.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/components/product/product_card.dart';
import 'package:benji/src/components/textformfield/message_textformfield.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/product_controller.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/models/rating/ratings.dart';
import 'package:benji/src/repo/utils/favorite.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:benji/src/repo/utils/vendor_note.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/components/others/cart_card.dart';
import '../../src/components/others/empty.dart';
import '../../src/components/rating_view/customer_review_card.dart';
import '../../src/components/section/custom_show_search.dart';
import '../../src/components/section/rate_product_dialog.dart';
import '../../src/components/snackbar/my_floating_snackbar.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';
import 'report_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  //==================================================== INITIAL STATE AND DISPOSE ======================================================\\
  @override
  void initState() {
    if (kDebugMode) {
      print('happen before all in product detail');
    }
    super.initState();

    cartCountAll = countCartItemByProduct(widget.product).toString();
    _isAddedToCart = countCartItemByProduct(widget.product) > 0;
    if (kDebugMode) {
      print('cartCountAll $cartCountAll _isAddedToCart $_isAddedToCart');
    }
    getFavoritePSingle(widget.product.id.toString()).then(
      (value) {
        setState(() {
          _isAddedToFavorites = value;
        });
      },
    );
    _vendorNoteEC.text = getSingleProductNote(widget.product);
    _getData();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController.removeListener(() {});
    super.dispose();
  }

  //============================================ CONTROLLERS ===========================================\\
  final TextEditingController _vendorNoteEC = TextEditingController();

  //============================================ FOCUS NODES ===========================================\\
  final FocusNode _vendorNoteFN = FocusNode();

  // Logic
  _saveNote() async {
    await addNoteToProduct(widget.product, _vendorNoteEC.text);
    setState(() {});
    if (kDebugMode) {
      print(_vendorNoteEC.text);
    }
  }

  _deleteNote() async {
    await removeNoteFromProduct(widget.product);
    setState(() {
      _vendorNoteEC.text = '';
    });
  }

  final List<String> stars = ['5', '4', '3', '2', '1'];
  String active = 'all';

  List<Ratings>? _ratings = [];

  _getData() async {
    setState(() {
      _ratings = null;
    });
    List<Ratings> ratings;
    if (active == 'all') {
      ratings = await getRatingsByProductId(widget.product.id.toString());
    } else {
      ratings = await getRatingsByProductIdAndRating(
          widget.product.id, int.parse(active));
    }

    setState(() {
      _ratings = ratings;
    });
  }

  //============================================================ ALL VARIABLES ===================================================================\\
  String? cartCountAll;
  final List<String> carouselImages = <String>[
    "assets/images/products/best-choice-restaurant.png",
    "assets/images/products/burgers.png",
    "assets/images/products/chizzy's-food.png",
    "assets/images/products/golden-toast.png",
    "assets/images/products/new-food.png",
    "assets/images/products/okra-soup.png",
    "assets/images/products/pasta.png"
  ];

//====================================================== BOOL VALUES ========================================================\\
  bool isScrollToTopBtnVisible = false;
  bool _isAddedToFavorites = false;
  bool _isAddedToCart = false;
  bool isLoading = false;

  //==================================================== CONTROLLERS ======================================================\\
  final scrollController = ScrollController();
  final carouselController = CarouselController();

  //==================================================== FUNCTIONS ======================================================\\
  void _toVendorPage (){
    Get.to(
          () => VendorDetails(vendor: widget.product.vendorId),
      routeName: 'VendorDetails',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void _toProductDetailScreenPage(product) {
    Get.off(
      () => ProductDetailScreen(product: product),
      routeName: 'ProductDetailScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  Future<void> scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      isScrollToTopBtnVisible = false;
    });
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels >= 200 &&
        isScrollToTopBtnVisible != true) {
      setState(() {
        isScrollToTopBtnVisible = true;
      });
    }
    if (scrollController.position.pixels < 200 &&
        isScrollToTopBtnVisible == true) {
      setState(() {
        isScrollToTopBtnVisible = false;
      });
    }
  }

  //============================ Favorite ================================\\

  void _addToFavorites() async {
    bool val = await favoriteItP(widget.product.id.toString());
    setState(() {
      _isAddedToFavorites = val;
    });

    mySnackBar(
      context,
      kSuccessColor,
      "Success",
      _isAddedToFavorites
          ? "Product has been added to favorites"
          : "Product been removed from favorites",
      const Duration(milliseconds: 500),
    );
  }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      cartCountAll = '0';
      _ratings = null;
    });
  }

  //============================= Cart utility functions ============================\\

  void incrementQuantity() async {
    await addToCart(widget.product);
    setState(() {
      cartCountAll = countCartItemByProduct(widget.product).toString();
      _isAddedToCart = countCartItemByProduct(widget.product) > 0;
    });
  }

  void decrementQuantity() async {
    await minusFromCart(widget.product);
    setState(() {
      cartCountAll = countCartItemByProduct(widget.product).toString();
      _isAddedToCart = countCartItemByProduct(widget.product) > 0;
    });
    if (countCartItemByProduct(widget.product) == 0) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Item has been removed from cart.",
        const Duration(
          seconds: 1,
        ),
      );
    }
  }

  Future<void> _cartAddFunction() async {
    await addToCart(widget.product);

    setState(() {
      cartCountAll = countCartItemByProduct(widget.product).toString();
      _isAddedToCart = countCartItemByProduct(widget.product) > 0;
    });

    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "Item has been added to cart.",
      const Duration(
        seconds: 1,
      ),
    );
  }

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
          value: 'search',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.magnifyingGlass, color: kAccentColor),
              kWidthSizedBox,
              const Text("Search for a product"),
            ],
          ),
        ), PopupMenuItem<String>(
          value: 'rate',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.solidStar, color: kStarColor),
              kWidthSizedBox,
              const Text("Rate this product"),
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
              const Text("Report this product"),
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle the selected value from the popup menu
      if (value != null) {
        switch (value) {
          case 'search':
            showSearch(context: context, delegate: CustomSearchDelegate());
            break;
          case 'rate':
            openRatingDialog(context);
            break;
          case 'report':
            Get.to(
              () => ReportProduct(product: widget.product),
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

  openRatingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding)),
          elevation: 50,
          child: RateProductDialog(product: widget.product),
        );
      },
    );
    await _getData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: MyAppBar(
            title: isScrollToTopBtnVisible? widget.product.name: "Product Detail",
            elevation: 0.0,
            actions: [
              Row(
                children: [

                  IconButton(
                    onPressed: _addToFavorites,
                    icon: FaIcon(
                      _isAddedToFavorites
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: kAccentColor,
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  CartCard(),
                ],
              ),
              IconButton(
                onPressed: () => showPopupMenu(context),
                icon: FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: kAccentColor,
                ),
              ),
            ],
            backgroundColor: kPrimaryColor,
          ),
          floatingActionButton: isScrollToTopBtnVisible
              ? FloatingActionButton(
                  onPressed: scrollToTop,
                  mini: true,
                  backgroundColor: kAccentColor,
                  enableFeedback: true,
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: "Scroll to top",
                  hoverColor: kAccentColor,
                  hoverElevation: 50.0,
                  child: FaIcon(FontAwesomeIcons.chevronUp,
                      size: 18, color: kPrimaryColor),
                )
              : const SizedBox(),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Scrollbar(
              controller: scrollController,
              radius: const Radius.circular(10),
              scrollbarOrientation: ScrollbarOrientation.right,
              child: ListView(
                shrinkWrap: true,
                controller: scrollController,
                physics: const ScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                children: [
                  Container(
                    decoration: const BoxDecoration(color: kGreyColor1),
                    height: media.height * 0.4,
                    child: MyImage(
                      url: widget.product.productImage,
                      radiusBottom: 0,
                      radiusTop: 0,
                    ),
                  ),
                  // FlutterCarousel.builder(
                  //   options: CarouselOptions(
                  //     height: deviceType(media.width) > 3 &&
                  //             deviceType(media.width) < 5
                  //         ? media.height * 0.5
                  //         : media.height * 0.42,
                  //     viewportFraction: 1.0,
                  //     initialPage: 0,
                  //     enableInfiniteScroll: true,
                  //     autoPlay: true,
                  //     autoPlayInterval: const Duration(seconds: 2),
                  //     autoPlayAnimationDuration:
                  //         const Duration(milliseconds: 800),
                  //     autoPlayCurve: Curves.easeInOut,
                  //     enlargeCenterPage: true,
                  //     controller: carouselController,
                  //     onPageChanged: (index, value) {
                  //       setState(() {});
                  //     },
                  //     pageSnapping: true,
                  //     scrollDirection: Axis.horizontal,
                  //     physics: const BouncingScrollPhysics(),
                  //     scrollBehavior: const ScrollBehavior(),
                  //     pauseAutoPlayOnTouch: true,
                  //     pauseAutoPlayOnManualNavigate: true,
                  //     pauseAutoPlayInFiniteScroll: false,
                  //     enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  //     disableCenter: false,
                  //     showIndicator: true,
                  //     floatingIndicator: true,
                  //     slideIndicator: CircularSlideIndicator(
                  //       alignment: Alignment.bottomCenter,
                  //       currentIndicatorColor: kAccentColor,
                  //       indicatorBackgroundColor: kPrimaryColor,
                  //       indicatorRadius: 5,
                  //       padding: const EdgeInsets.all(10),
                  //     ),
                  //   ),
                  //   itemCount: carouselImages.length,
                  //   itemBuilder: (BuildContext context, int itemIndex,
                  //           int pageViewIndex) =>
                  //       Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Container(
                  //       width: media.width,
                  //       decoration: ShapeDecoration(
                  //         shape: const RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(20))),
                  //         image: DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: AssetImage(
                  //             carouselImages[itemIndex],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  kSizedBox,
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: media.width,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFEF8F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFFDEDED),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 24,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width: media.width * 0.4,
                                    child: Text(
                                      widget.product.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: kTextBlackColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    width: media.width * 0.4,
                                    child: Text(
                                      "₦ ${formattedText(widget.product.price)}",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: kTextBlackColor,
                                        fontSize: 22,
                                        fontFamily: 'sen',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        kSizedBox,
                        SizedBox(
                          width: media.width / 3,
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
                                  text: widget.product.quantityAvailable
                                      .toString(),
                                  style: const TextStyle(
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
                          width: media.width,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFEF8F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFFDEDED),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 24,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Description",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              ReadMoreText(
                                widget.product.description,
                                callback: (value) {},
                                colorClickableText: kAccentColor,
                                moreStyle: TextStyle(color: kAccentColor),
                                lessStyle: TextStyle(color: kAccentColor),
                                delimiter: "...",
                                delimiterStyle: TextStyle(color: kAccentColor),
                                trimMode: TrimMode.Line,
                                trimLines: 4,
                              ),
                            ],
                          ),
                        ),
                        kSizedBox,
                        GetBuilder<ProductController>(
                          builder: (controller) {
                            return Container(
                              width: media.width,
                              // padding: const EdgeInsets.all(kDefaultPadding),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFEF8F8),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 0.50,
                                    color: Color(0xFFFDEDED),
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0F000000),
                                    blurRadius: 24,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: _toVendorPage,
                                leading: FaIcon(FontAwesomeIcons.shop, color: kAccentColor, size: 20),
                                title: Text(
                                  "About vendor",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kTextGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: FaIcon(FontAwesomeIcons.chevronRight, color: kAccentColor, size: 20),
                              ),
                            );
                          }
                        ),
                        kSizedBox,
                        cartCountAll == null
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(
                                  bottom: kDefaultPadding * 2,
                                ),
                                child: _isAddedToCart
                                    ? Container(
                                        width: media.width,
                                        height: 55,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFAFAFA),
                                          shadows: [
                                            BoxShadow(
                                              color:
                                                  kBlackColor.withOpacity(0.1),
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              blurStyle: BlurStyle.normal,
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(19),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                decrementQuantity();
                                              },
                                              splashRadius: 10,
                                              icon: const Icon(
                                                Icons.remove,
                                                color: kBlackColor,
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              decoration: ShapeDecoration(
                                                color: kAccentColor,
                                                shape: const OvalBorder(),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kDefaultPadding /
                                                                2),
                                                child: Center(
                                                  child: Text(
                                                    cartCountAll ?? '0',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: kTextWhiteColor,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                incrementQuantity();
                                              },
                                              splashRadius: 10,
                                              icon: Icon(
                                                Icons.add,
                                                color: kAccentColor,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : MyElevatedButton(
                                        onPressed: () {
                                          _cartAddFunction();
                                        },
                                        title:
                                            "Add to Cart (₦${formattedText(widget.product.price)})",
                                      ),
                              ),
                        _isAddedToCart
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyMessageTextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        _vendorNoteEC.text = value;
                                      });
                                    },
                                    controller: _vendorNoteEC,
                                    textInputAction: TextInputAction.done,
                                    focusNode: _vendorNoteFN,
                                    hintText: "Note for vendor (Optional)",
                                    maxLines: 5,
                                    keyboardType: TextInputType.text,
                                    maxLength: 3000,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  kSizedBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _vendorNoteEC.text == ''
                                            ? null
                                            : _deleteNote,
                                        style: ElevatedButton.styleFrom(
                                          fixedSize:
                                              Size((media.width / 2 - 20), 40),
                                          backgroundColor:
                                              kDefaultCategoryBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          'Delete',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: kTextGreyColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _vendorNoteEC.text == '' ||
                                                _vendorNoteEC.text ==
                                                    getSingleProductNote(
                                                        widget.product)
                                            ? null
                                            : _saveNote,
                                        style: ElevatedButton.styleFrom(
                                          disabledBackgroundColor:
                                              kAccentColor.withOpacity(0.5),
                                          fixedSize:
                                              Size((media.width / 2 - 20), 40),
                                          backgroundColor: kAccentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  kSizedBox,
                                ],
                              )
                            : kSizedBox,
                        // similar products will go here
                        kSizedBox,
                        const Text(
                          "Similar products",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Divider(height: kDefaultPadding, color: kGreyColor1),
                        kSizedBox,
                        GetBuilder<ProductController>(
                            initState: (state) =>
                                ProductController.instance.getProduct(),
                            builder: (controller) {
                              if (controller.isLoad.value &&
                                  controller.products.isEmpty) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kAccentColor,
                                  ),
                                );
                              }
                              List<Product> products =
                                  controller.products.value;
                              products.shuffle();
                              return SizedBox(
                                height: 350,
                                width: media.width,
                                child: ListView.separated(
                                  itemCount: min(controller.products.length, 3),
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      deviceType(media.width) > 2
                                          ? kWidthSizedBox
                                          : kHalfWidthSizedBox,
                                  itemBuilder: (context, index) => InkWell(
                                    child: SizedBox(
                                      width: 200,
                                      child: ProductCard(
                                        product: products[index],
                                        onTap: () {
                                          _toProductDetailScreenPage(
                                              products[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        kSizedBox,
                        Container(
                          width: media.width,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFEF8F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFFDEDED),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 24,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reviews View & Ratings",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kSizedBox,
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: active == 'all'
                                              ? kAccentColor
                                              : const Color(
                                                  0xFFA9AAB1,
                                                ),
                                        ),
                                        backgroundColor: active == 'all'
                                            ? kAccentColor
                                            : kPrimaryColor,
                                        foregroundColor: active == 'all'
                                            ? kPrimaryColor
                                            : const Color(0xFFA9AAB1),
                                      ),
                                      onPressed: () async {
                                        active = 'all';

                                        setState(() {
                                          _ratings = null;
                                        });

                                        List<Ratings> ratings =
                                            await getRatingsByProductId(
                                                widget.product.id.toString());

                                        setState(() {
                                          _ratings = ratings;
                                        });
                                      },
                                      child: const Text(
                                        'All',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: stars
                                          .map(
                                            (item) => Row(
                                              children: [
                                                kHalfWidthSizedBox,
                                                OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                      color: active == item
                                                          ? kStarColor
                                                          : const Color(
                                                              0xFFA9AAB1),
                                                    ),
                                                    foregroundColor:
                                                        active == item
                                                            ? kStarColor
                                                            : const Color(
                                                                0xFFA9AAB1),
                                                  ),
                                                  onPressed: () async {
                                                    active = item;

                                                    setState(() {
                                                      _ratings = null;
                                                    });

                                                    List<Ratings> ratings =
                                                        await getRatingsByProductIdAndRating(
                                                            widget.product.id,
                                                            int.parse(active));

                                                    setState(() {
                                                      _ratings = ratings;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const FaIcon(
                                                        FontAwesomeIcons
                                                            .solidStar,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(
                                                        width: kDefaultPadding *
                                                            0.2,
                                                      ),
                                                      Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    kHalfWidthSizedBox,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        kSizedBox,
                        _ratings == null
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : _ratings!.isEmpty
                                ? const EmptyCard(
                                    showButton: false,
                                    emptyCardMessage:
                                        "There are no reviews for this product.",
                                  )
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        kSizedBox,
                                    shrinkWrap: true,
                                    itemCount: _ratings!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            CostumerReviewCard(
                                                rating: _ratings![index]),
                                  ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
