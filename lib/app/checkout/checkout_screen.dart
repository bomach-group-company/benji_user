// ignore_for_file: unused_local_variable

import 'package:benji_user/app/payment/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../address/deliver_to.dart';
import '../coupon/apply_coupon.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  //=================================== ALL VARIABLES ==========================================\\

  int quantity = 1;
  double price = 4200.0;
  final double itemPrice = 4200.0;

  double deliveryFee = 700.00;
  double serviceFee = 0.00;
  double insuranceFee = 0.00;
  double discountFee = 0.00;
  double calculateTotalPrice() {
    return (itemPrice * quantity) +
        deliveryFee +
        serviceFee +
        insuranceFee +
        discountFee;
  }

  //===================== GlobalKeys =======================\\

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //===================== CONTROLLERS =======================\\

  ScrollController scrollController = ScrollController();

  //===================== BOOL VALUES =======================\\
  bool isLoading = false;

  //===================== FUNCTIONS =======================\\

  void incrementQuantity() {
    setState(() {
      quantity++;
      price = quantity * itemPrice;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        price = quantity * itemPrice;
      }
    });
  }

  // COPY TO CLIPBOARD
  final String text = 'Generated Link code here';

  //PLACE ORDER

  void _placeOrder() async {
    Get.to(
      () => const PaymentMethod(),
      routeName: 'PaymentMethod',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    var mediaHeight = MediaQuery.of(context).size.height;
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: "Checkout",
        actions: [],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                child: Text(
                  'Deliver to',
                  style: TextStyle(
                    color: Color(
                      0xFF202020,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              kSizedBox,
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeliverTo(),
                    ),
                  );
                },
                child: Container(
                  width: mediaWidth,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'School',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(
                                0xFF151515,
                              ),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kSizedBox,
                          Text(
                            'No 2 Chime Avenue New Haven Enugu.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(
                                0xFF4C4C4C,
                              ),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kAccentColor,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Container(
                child: Text(
                  'Product Summary',
                  style: TextStyle(
                    color: Color(
                      0xFF151515,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              kSizedBox,
              Container(
                width: mediaWidth,
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(
                        0x0F000000,
                      ),
                      blurRadius: 24,
                      offset: Offset(
                        0,
                        4,
                      ),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Smokey Jollof Rice',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(
                                    0xFF333333,
                                  ),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                '2x  Stewed Fried Chicken',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(
                                    0xFF676565,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                '2x Grilled 1/4 Chicken',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(
                                    0xFF676565,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_shopping_cart_rounded,
                              color: kAccentColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₦${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Color(
                                0xCC4C4C4C,
                              ),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    decrementQuantity();
                                  },
                                  child: Icon(
                                    Icons.remove_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    incrementQuantity();
                                  },
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              kSizedBox,
              Container(
                width: mediaWidth,
                padding: EdgeInsets.all(
                  kDefaultPadding,
                ),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(
                        0x0F000000,
                      ),
                      blurRadius: 24,
                      offset: Offset(
                        0,
                        4,
                      ),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coupon',
                        style: TextStyle(
                          color: Color(
                            0xFF151515,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(
                                0xFFEAEAEA,
                              ),
                            ),
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ApplyCoupon(),
                            ),
                          );
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Coupon',
                                style: TextStyle(
                                  color: Color(
                                    0xFF151515,
                                  ),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 24,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: kAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ADB1897',
                                            style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'x',
                                            style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: kAccentColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBox,
              Container(
                width: mediaWidth,
                padding: EdgeInsets.all(
                  kDefaultPadding,
                ),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(
                        0x0F000000,
                      ),
                      blurRadius: 24,
                      offset: Offset(
                        0,
                        4,
                      ),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Payment Summary',
                              style: TextStyle(
                                color: Color(
                                  0xFF151515,
                                ),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(
                                      0xFFEAEAEA,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF151515,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Color(
                                        0xCC4C4C4C,
                                      ),
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Fee',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF151515,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${deliveryFee.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Color(
                                        0xCC4C4C4C,
                                      ),
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service Fee',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF151515,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${serviceFee.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Color(
                                        0xCC4C4C4C,
                                      ),
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Insurance Fee',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF151515,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${insuranceFee.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Color(
                                        0xCC4C4C4C,
                                      ),
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kSizedBox,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF151515,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${discountFee.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Color(
                                        0xCC4C4C4C,
                                      ),
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(
                                0xFFEAEAEA,
                              ),
                            ),
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Color(
                                  0xFF151515,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '₦${totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Color(
                                  0xCC4C4C4C,
                                ),
                                fontSize: 16,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? Center(
                          child: SpinKitChasingDots(
                            color: kAccentColor,
                            duration: const Duration(seconds: 1),
                          ),
                        )
                      : MyElevatedButton(
                          title:
                              "Place Order - ₦${totalPrice.toStringAsFixed(2)}",
                          onPressed: () {
                            _placeOrder();
                          },
                        ),
                  kSizedBox,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//==================================================================== FUTURE REFERENCE ======================================================================================\\
                  // MyOutlinedElevatedButton(
                  //   title: "Pay For Me\n (Coming soon 😊)",
                  //   onPressed: 
                  //   () {
                  //     showModalBottomSheet(
                  //       context: context,
                  //       backgroundColor: kPrimaryColor,
                  //       elevation: 20,
                  //       barrierColor: kBlackColor.withOpacity(
                  //         0.2,
                  //       ),
                  //       showDragHandle: true,
                  //       useSafeArea: true,
                  //       constraints: BoxConstraints(
                  //         maxHeight: MediaQuery.of(context).size.height * 0.8,
                  //         minHeight: MediaQuery.of(context).size.height * 0.5,
                  //       ),
                  //       isScrollControlled: true,
                  //       isDismissible: true,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //           top: Radius.circular(
                  //             kDefaultPadding,
                  //           ),
                  //         ),
                  //       ),
                  //       enableDrag: true,
                  //       builder: (context) => Container(
                  //         margin: EdgeInsets.symmetric(
                  //           horizontal: kDefaultPadding,
                  //         ),
                  //         // color: kAccentColor,
                  //         child: ListView(
                  //           physics: const BouncingScrollPhysics(),
                  //           scrollDirection: Axis.vertical,
                  //           children: [
                  //             Container(
                  //               height: 65,
                  //               padding: const EdgeInsets.all(
                  //                 8,
                  //               ),
                  //               child: Text(
                  //                 'Hey! share this link with your friends to have them pay for your order',
                  //                 style: TextStyle(
                  //                   color: Color(
                  //                     0xFF333333,
                  //                   ),
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w400,
                  //                 ),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: kDefaultPadding,
                  //             ),
                  //             Container(
                  //               height: 64,
                  //               padding: const EdgeInsets.only(
                  //                 top: 16,
                  //                 left: 17,
                  //                 right: 17,
                  //                 bottom: 18,
                  //               ),
                  //               decoration: ShapeDecoration(
                  //                 color: Color(
                  //                   0xFFFEF8F8,
                  //                 ),
                  //                 shape: RoundedRectangleBorder(
                  //                   side: BorderSide(
                  //                     width: 0.50,
                  //                     color: Color(
                  //                       0xFFFDEDED,
                  //                     ),
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(
                  //                     10,
                  //                   ),
                  //                 ),
                  //               ),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   Text(
                  //                     text,
                  //                     style: TextStyle(
                  //                       color: kBlackColor,
                  //                       fontSize: 12,
                  //                       fontWeight: FontWeight.w400,
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     margin: EdgeInsets.only(
                  //                       left: kDefaultPadding * 4,
                  //                     ),
                  //                     width: 2,
                  //                     height: 30,
                  //                     decoration: BoxDecoration(
                  //                       color: Color(
                  //                         0xFFA39B9B,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   kHalfWidthSizedBox,
                  //                   IconButton(
                  //                     onPressed: () =>
                  //                         _copyToClipboard(context),
                  //                     icon: Icon(
                  //                       Icons.content_copy_rounded,
                  //                       color: kAccentColor,
                  //                       size: 14,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             kSizedBox,
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Container(
                  //                         child: Column(
                  //                           children: [
                  //                             Container(
                  //                               height: 80,
                  //                               width: 80,
                  //                               decoration: BoxDecoration(
                  //                                 image: DecorationImage(
                  //                                   image: AssetImage(
                  //                                     "assets/images/icons/whatsapp-icon.png",
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               'WhatsApp',
                  //                               textAlign: TextAlign.center,
                  //                               style: TextStyle(
                  //                                 color: Color(
                  //                                   0xFF3C3E56,
                  //                                 ),
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Container(
                  //                         child: Column(
                  //                           children: [
                  //                             Container(
                  //                               height: 80,
                  //                               width: 80,
                  //                               decoration: BoxDecoration(
                  //                                 image: DecorationImage(
                  //                                   image: AssetImage(
                  //                                     "assets/images/icons/facebook-icon.png",
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               'Facebook',
                  //                               textAlign: TextAlign.center,
                  //                               style: TextStyle(
                  //                                 color: Color(
                  //                                   0xFF3C3E56,
                  //                                 ),
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Container(
                  //                         child: Column(
                  //                           children: [
                  //                             Container(
                  //                               height: 80,
                  //                               width: 80,
                  //                               decoration: BoxDecoration(
                  //                                 image: DecorationImage(
                  //                                   image: AssetImage(
                  //                                     "assets/images/icons/messenger-icon.png",
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               'Messenger',
                  //                               textAlign: TextAlign.center,
                  //                               style: TextStyle(
                  //                                 color: Color(
                  //                                   0xFF3C3E56,
                  //                                 ),
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Container(
                  //                         child: Column(
                  //                           children: [
                  //                             Container(
                  //                               height: 80,
                  //                               width: 80,
                  //                               decoration: BoxDecoration(
                  //                                 image: DecorationImage(
                  //                                   image: AssetImage(
                  //                                     "assets/images/icons/messages-icon.png",
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               'Message',
                  //                               textAlign: TextAlign.center,
                  //                               style: TextStyle(
                  //                                 color: Color(
                  //                                   0xFF3C3E56,
                  //                                 ),
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   kHalfSizedBox,
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       InkWell(
                  //                         onTap: () {},
                  //                         child: Container(
                  //                           child: Column(
                  //                             children: [
                  //                               Container(
                  //                                 height: 80,
                  //                                 width: 80,
                  //                                 decoration: BoxDecoration(
                  //                                   image: DecorationImage(
                  //                                     image: AssetImage(
                  //                                       "assets/images/icons/instagram-icon.png",
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               Text(
                  //                                 'Instagram',
                  //                                 textAlign: TextAlign.center,
                  //                                 style: TextStyle(
                  //                                   color: Color(
                  //                                     0xFF3C3E56,
                  //                                   ),
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.w400,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {},
                  //                         child: Container(
                  //                           child: Column(
                  //                             children: [
                  //                               Container(
                  //                                 height: 80,
                  //                                 width: 80,
                  //                                 decoration: BoxDecoration(
                  //                                   image: DecorationImage(
                  //                                     image: AssetImage(
                  //                                       "assets/images/icons/twitter-icon.png",
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               Text(
                  //                                 'Twitter',
                  //                                 textAlign: TextAlign.center,
                  //                                 style: TextStyle(
                  //                                   color: Color(
                  //                                     0xFF3C3E56,
                  //                                   ),
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.w400,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {},
                  //                         child: Container(
                  //                           child: Column(
                  //                             children: [
                  //                               Container(
                  //                                 height: 80,
                  //                                 width: 80,
                  //                                 decoration: BoxDecoration(
                  //                                   image: DecorationImage(
                  //                                     image: AssetImage(
                  //                                       "assets/images/icons/telegram-icon.png",
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               Text(
                  //                                 'Telegram',
                  //                                 textAlign: TextAlign.center,
                  //                                 style: TextStyle(
                  //                                   color: Color(
                  //                                     0xFF3C3E56,
                  //                                   ),
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.w400,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {},
                  //                         child: Container(
                  //                           child: Column(
                  //                             children: [
                  //                               Container(
                  //                                 height: 80,
                  //                                 width: 80,
                  //                                 decoration: BoxDecoration(
                  //                                   image: DecorationImage(
                  //                                     image: AssetImage(
                  //                                       "assets/images/icons/linkedin-icon.png",
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               Text(
                  //                                 'LinkedIn',
                  //                                 textAlign: TextAlign.center,
                  //                                 style: TextStyle(
                  //                                   color: Color(
                  //                                     0xFF3C3E56,
                  //                                   ),
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.w400,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: kDefaultPadding * 4,
                  //             ),
                  //             MyElevatedButton(
                  //               title: "Close",
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),