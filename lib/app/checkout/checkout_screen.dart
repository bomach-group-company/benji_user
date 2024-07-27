// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:benji/app/home/home.dart';
import 'package:benji/app/splash_screens/payment_successful_screen.dart';
import 'package:benji/src/components/payment/monnify.dart';
import 'package:benji/src/components/payment/monnify_mobile.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/controller/notifications_controller.dart';
import 'package:benji/src/repo/controller/order_confirm_status.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/models/product/product.dart';
import 'package:benji/src/repo/utils/constants.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/src/repo/utils/user_cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_monnify/flutter_monnify.dart';
// import 'package:flutter_squad/flutter_squad.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/keys.dart';
import '../../src/repo/controller/error_controller.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../theme/colors.dart';

class CheckoutScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> formatOfOrder;
  final Order order;
  final Address deliverTo;

  const CheckoutScreen({
    super.key,
    required this.formatOfOrder,
    required this.order,
    required this.index,
    required this.deliverTo,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _secondsRemaining = 60;
  bool secondClick = false;

  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  //=================================== INITIAL STATE ==========================================\\
  @override
  void initState() {
    super.initState();
    // remove from cart on this page
    // CartController.instance.clearCartProduct(widget.index);
    Get.put(OrderConfirmStatusController());
    OrderConfirmStatusController.instance.getOrderConfirmStatus(widget.order);

    _getData();
    checkAuth(context);
    checkIfShoppingLocation(context);
    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //=================================== ALL VARIABLES ==========================================\\
  User? user;
  Map? _data;
  double _subTotal = 0;
  double _totalPrice = 0;
  double deliveryFee = OrderController.instance.deliveryFee.value;
  // final String _paymentDescription = "Benji app product purchase";
  final String currency = "NGN";

  //===================== GlobalKeys =======================\\

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //===================== CONTROLLERS =======================\\

  final ScrollController _scrollController = ScrollController();

  //===================== BOOL VALUES =======================\\
  final bool _isLoading = false;

  //===================== FUNCTIONS =======================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }

  _getData() async {
    consoleLog('formatOfOrder ${widget.formatOfOrder}');
    _subTotal = 0;

    List<Product> product = CartController.instance.cartProducts[widget.index];

    Map<String, dynamic> cartItems = getCartProductId(widget.index);

    Address? deliverTo;
    try {
      deliverTo = widget.deliverTo;
    } catch (e) {
      deliverTo = null;
    }

    for (Product item in product) {
      _subTotal += (item.price * cartItems[item.id].quantity);
    }

    _totalPrice = _subTotal + deliveryFee;

    setState(() {
      _data = {
        'deliverTo': deliverTo,
        'product': product,
        'cartItems': cartItems,
      };
    });
  }

  // COPY TO CLIPBOARD
  final String text = 'Generated Link code here';

  //PLACE ORDER
  void _placeOrder() {
    String apiKey = monnifyAPIkey;
    String contractCode = contractCodeKey;
    String email = UserController.instance.user.value.email;
    String phone = UserController.instance.user.value.phone;
    String firstName = UserController.instance.user.value.firstName;
    String lastName = UserController.instance.user.value.lastName;
    String currency = 'NGN';
    String amount = (_subTotal + deliveryFee).ceil().toString();
    Map meta = {
      "the_item_id": widget.order.id,
      'the_item_type': 'order',
      'client_id': UserController.instance.user.value.id
    };
    try {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          if (kIsWeb) {
            return MonnifyWidget(
              apiKey: apiKey,
              contractCode: contractCode,
              email: email,
              phone: phone,
              firstName: firstName,
              lastName: lastName,
              currency: currency,
              amount: amount,
              metaData: meta,
              onClose: () {
                Get.back();
              },
              onTransaction: (response) async {
                consoleLog('the response from my alatpay $response');
                if (response != null && response['status'] == "SUCCESS") {
                  await CartController.instance.clearCartProduct(widget.index);
                  await NotificationController.showNotification(
                    title: "Payment Success",
                    body: "Your payment of NGN$amount was successful",
                    largeIcon: "asset://assets/icons/success.png",
                    customSound: "asset://assets/audio/benji.wav",
                  );
                  CartController.instance.cartTotalNumberForAll();
                  Get.off(
                    () => PaymentSuccessful(
                      order: widget.order,
                    ),
                    routeName: 'PaymentSuccessful',
                    duration: const Duration(milliseconds: 300),
                    fullscreenDialog: true,
                    curve: Curves.easeIn,
                    preventDuplicates: true,
                    popGesture: true,
                    transition: Transition.rightToLeft,
                  );
                }
              },
            );
          } else {
            return MonnifyWidgetMobile(
              apiKey: apiKey,
              contractCode: contractCode,
              email: email,
              phone: phone,
              firstName: firstName,
              lastName: lastName,
              currency: currency,
              amount: amount,
              metaData: meta,
              onClose: () {
                Get.back();
              },
              onTransaction: (response) async {
                consoleLog('the response from my alatpay $response');
                if (response != null && response['status'] == "SUCCESS") {
                  await CartController.instance.clearCartProduct(widget.index);
                  await NotificationController.showNotification(
                    title: "Payment Success",
                    body: "Your payment of NGN$amount was successful",
                    largeIcon: "asset://assets/icons/success.png",
                    customSound: "asset://assets/audio/benji.wav",
                  );
                  Get.off(
                    () => PaymentSuccessful(
                      order: widget.order,
                    ),
                    routeName: 'PaymentSuccessful',
                    duration: const Duration(milliseconds: 300),
                    fullscreenDialog: true,
                    curve: Curves.easeIn,
                    preventDuplicates: true,
                    popGesture: true,
                    transition: Transition.rightToLeft,
                  );
                }
              },
            );
          }
        }),
      );
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
  }

  String generateRandomString(int len) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        len,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  void _toHomeScreen() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        predicate: (routes) => false,
        transition: Transition.rightToLeft,
      );

  void _toDeliverTo() async {
    Get.back();
    Address? deliverTo;
    try {
      deliverTo = await getCurrentAddress();
    } catch (e) {
      deliverTo = null;
    }
    setState(() {
      _data!['deliverTo'] = deliverTo;
    });
    // await _getData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: "Checkout",
        actions: [
          IconButton(
            onPressed: _toHomeScreen,
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 18,
              semanticLabel: "Home",
              color: kAccentColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: _data == null
            ? Center(
                child: Center(
                    child: CircularProgressIndicator(color: kAccentColor)),
              )
            : RefreshIndicator(
                onRefresh: _handleRefresh,
                color: kAccentColor,
                displacement: kDefaultPadding,
                semanticsLabel: "Pull to refresh",
                child: () {
                  if (_data!['product'].isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Center(
                        child: Column(
                          children: [
                            kSizedBox,
                            Lottie.asset(
                              "assets/animations/empty/frame_2.json",
                            ),
                            kSizedBox,
                            Text(
                              "Oops!, Your cart is empty",
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kSizedBox,
                            MyElevatedButton(
                              title: "Start shopping",
                              onPressed: _toHomeScreen,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Scrollbar(
                    controller: _scrollController,
                    child: ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(kDefaultPadding),
                      children: [
                        const Text(
                          'Delivery location',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        InkWell(
                          onTap: _toDeliverTo,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: media.width,
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
                                  spreadRadius: 7,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.deliverTo.title.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: kTextBlackColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    kSizedBox,
                                    SizedBox(
                                      width: media.width - 100,
                                      child: Text(
                                        widget.deliverTo.details,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: kTextGreyColor,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: kAccentColor,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        const Text(
                          'Product Summary',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        Container(
                          width: media.width,
                          padding: const EdgeInsets.all(kDefaultPadding),
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
                                spreadRadius: 7,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Scrollbar(
                                controller: _scrollController,
                                child: ListView.separated(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  itemCount: _data!['product'].length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return kHalfSizedBox;
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: media.width,
                                      child: Text(
                                        '${_data!['cartItems'][_data!['product'][index].id].quantity}x  ${_data!['product'][index].name}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: kTextGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        kSizedBox,
                        Container(
                          width: media.width,
                          padding: const EdgeInsets.all(kDefaultPadding),
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
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Payment Summary',
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Divider(height: 20, color: kGreyColor1),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Subtotal',
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '₦${formattedText(_subTotal)}',
                                        style: TextStyle(
                                          color: kTextGreyColor,
                                          fontSize: 16,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kSizedBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Delivery Fee',
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '₦${formattedText(deliveryFee)}',
                                        style: TextStyle(
                                          color: kTextGreyColor,
                                          fontSize: 16,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              kHalfSizedBox,
                              const Divider(height: 4, color: kGreyColor1),
                              kHalfSizedBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      color: kTextBlackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₦${formattedText(_totalPrice)}',
                                    style: TextStyle(
                                      color: kTextGreyColor,
                                      fontSize: 16,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding * 2),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : GetBuilder<OrderConfirmStatusController>(
                                builder: (controller) {
                                return Column(
                                  children: [
                                    controller.confirmed.value == false
                                        ? Text(
                                            "Vendor cancelled reason: ${controller.reason.value ?? 'Unknown reason'}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : (controller.confirmed.value ?? false)
                                            ? const Text(
                                                'The vendor has confirmed your order, please click proceed',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            : _secondsRemaining <= 0
                                                ? !secondClick
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'Vendor is yet to accept your order: ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _secondsRemaining =
                                                                      60;
                                                                  secondClick =
                                                                      true;
                                                                });
                                                              },
                                                              child: Text(
                                                                'Try again',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        kAccentColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ))
                                                        ],
                                                      )
                                                    : Wrap(
                                                        alignment: WrapAlignment
                                                            .center,
                                                        children: [
                                                          const Text(
                                                            'Order saved on draft. you can',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          InkWell(
                                                              onTap:
                                                                  _toHomeScreen,
                                                              child: Text(
                                                                ' continue ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        kAccentColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              )),
                                                          const Text(
                                                            'with your shopping while we wait for the vendor.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      )
                                                : Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      const Text(
                                                        'Waiting for the vendor to confirm your order before you make payment: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        '${_secondsRemaining}sec',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: kAccentColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                    kSizedBox,
                                    MyElevatedButton(
                                      disable: !(controller.confirmed.value ??
                                          false),
                                      title: "Proceed",
                                      onPressed:
                                          (controller.confirmed.value ?? false)
                                              ? _placeOrder
                                              : null,
                                    ),
                                  ],
                                );
                              }),
                        kSizedBox,
                      ],
                    ),
                  );
                }(),
              ),
      ),
    );
  }
}
