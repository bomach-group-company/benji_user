import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/src/repo/utils/favorite.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/cart.dart';
import '../../src/common_widgets/rating_view/customer_review_card.dart';
import '../../src/common_widgets/rating_view/star_row.dart';
import '../../src/common_widgets/section/rate_product_dialog.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/repo/utils/cart.dart';
import '../../theme/colors.dart';
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
    getFavoritePSingle(widget.product.id).then(
      (value) {
        _isAddedToFavorites = value;
      },
    );
    checkCart();
    _getData();
  }

  Map? _data;

  _getData() async {
    await checkAuth(context);
    // List<Ratings> ratings = await getRatingsByVendorId(widget.vendor.id!);
    // setState(() {
    //   _data = {'ratings': ratings};
    // });
  }

  //============================================================ ALL VARIABLES ===================================================================\\
  String cartCount = '1';
  String cartCountAll = '1';
  List<String> _carouselImages = <String>[
    "assets/images/products/best-choice-restaurant.png",
    "assets/images/products/burgers.png",
    "assets/images/products/chizzy's-food.png",
    "assets/images/products/golden-toast.png",
    "assets/images/products/new-food.png",
    "assets/images/products/okra-soup.png",
    "assets/images/products/pasta.png"
  ];

//====================================================== BOOL VALUES ========================================================\\
  bool _isAddedToFavorites = false;
  bool _isAddedToCart = false;
  bool isLoading = false;
  bool justInPage = true;

  //==================================================== CONTROLLERS ======================================================\\
  ScrollController _scrollController = ScrollController();
  CarouselController _carouselController = CarouselController();

  //==================================================== FUNCTIONS ======================================================\\

  checkCart() async {
    await checkAuth(context);
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

  //============================ Favorite ================================\\

  void _addToFavorites() async {
    bool val = await favoriteItP(widget.product.id);
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
      Duration(milliseconds: 500),
    );
  }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    justInPage = true;
    await checkCart();
  }

  //============================= Cart utility functions ============================\\

  void incrementQuantity() async {
    await addToCart(widget.product.id);
    await checkCart();
  }

  void decrementQuantity() async {
    await removeFromCart(widget.product.id);
    await checkCart();
  }

  Future<void> _cartAddFunction() async {
    await addToCart(widget.product.id);
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

  openRatingDialog(BuildContext context) {
    showDialog(
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
                      onPressed: _addToFavorites,
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
              onPressed: () => showPopupMenu(context),
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
          child: cartCount == false
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView(
                    physics: const ScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
                    children: [
                      FlutterCarousel.builder(
                        options: CarouselOptions(
                          height: mediaHeight * 0.42,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true,
                          controller: _carouselController,
                          onPageChanged: (index, value) {},
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          scrollBehavior: ScrollBehavior(),
                          pauseAutoPlayOnTouch: true,
                          pauseAutoPlayOnManualNavigate: true,
                          pauseAutoPlayInFiniteScroll: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          disableCenter: false,
                          showIndicator: true,
                          floatingIndicator: true,
                          slideIndicator: CircularSlideIndicator(
                            alignment: Alignment.bottomCenter,
                            currentIndicatorColor: kAccentColor,
                            indicatorBackgroundColor: kPrimaryColor,
                            indicatorRadius: 5,
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        itemCount: _carouselImages.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: mediaWidth,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  _carouselImages[itemIndex],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      kSizedBox,
                      Padding(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: mediaWidth,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        width: mediaWidth / 2.3,
                                        child: Text(
                                          widget.product.name,
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
                                        width: mediaWidth / 3,
                                        child: Text(
                                          "₦ ${formattedText(widget.product.price)}",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          style: TextStyle(
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
                              width: mediaWidth / 3,
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
                                      text: formattedText(widget
                                          .product.quantityAvailable
                                          .toDouble()),
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
                              width: mediaWidth,
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
                                    delimiterStyle:
                                        TextStyle(color: kAccentColor),
                                    trimMode: TrimMode.Line,
                                    trimLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            isLoading
                                ? Column(
                                    children: [
                                      Center(
                                        child: SpinKitChasingDots(
                                          color: kAccentColor,
                                          duration: const Duration(seconds: 1),
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
                                        ? Container(
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
                                                  splashRadius: 50,
                                                  icon: Icon(
                                                    Icons.remove_rounded,
                                                    color: kBlackColor,
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                    color: kAccentColor,
                                                    shape: OvalBorder(),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                            kDefaultPadding /
                                                                2),
                                                    child: Center(
                                                      child: Text(
                                                        '$cartCountAll',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              kTextWhiteColor,
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
                                                  splashRadius: 50,
                                                  icon: Icon(
                                                    Icons.add_rounded,
                                                    color: kAccentColor,
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
                            kSizedBox,
                            Container(
                              width: mediaWidth,
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
                                    "Reviews View & Ratings",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: kDefaultPadding,
                                      horizontal: kDefaultPadding * 0.5,
                                    ),
                                    child: StarRow(),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            _data == null
                                ? Center(
                                    child:
                                        SpinKitChasingDots(color: kAccentColor))
                                : ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        kSizedBox,
                                    shrinkWrap: true,
                                    itemCount: _data!['ratings'].length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        CostumerReviewCard(
                                            rating: _data!['ratings'][index]),
                                  ),
                            SizedBox(
                              height: kDefaultPadding * 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
