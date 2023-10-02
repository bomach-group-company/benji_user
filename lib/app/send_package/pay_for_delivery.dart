// ignore_for_file: use_build_context_synchronously

import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monnify/flutter_monnify.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/keys.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../src/repo/utils/base_url.dart';
import '../home/home.dart';

class PayForDelivery extends StatefulWidget {
  final String status,
      senderName,
      senderPhoneNumber,
      receiverName,
      receiverPhoneNumber,
      receiverLocation,
      itemName,
      itemCategoryId,
      itemQuantity,
      itemWeight,
      itemValue;

  const PayForDelivery(
      {super.key,
      required this.status,
      required this.senderName,
      required this.senderPhoneNumber,
      required this.receiverName,
      required this.receiverPhoneNumber,
      required this.receiverLocation,
      required this.itemName,
      required this.itemQuantity,
      required this.itemWeight,
      required this.itemValue,
      required this.itemCategoryId});

  @override
  State<PayForDelivery> createState() => _PayForDeliveryState();
}

class _PayForDeliveryState extends State<PayForDelivery> {
  //=================================== INITIAL STATE ==========================================\\
  @override
  void initState() {
    super.initState();
    _getUserData();
    _getTotalPrice();

    _scrollController.addListener(_scrollListener);
    _packageData = <String>[
      widget.status,
      widget.senderName,
      "$countryDialCode ${widget.senderPhoneNumber}",
      widget.receiverName,
      "$countryDialCode ${widget.receiverPhoneNumber}",
      widget.receiverLocation,
      widget.itemName,
      widget.itemQuantity,
      widget.itemWeight,
      "₦ ${widget.itemValue}"
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(() {});
  }
  //=================================== ALL VARIABLES ==========================================\\

  // Map? _data;
  String countryDialCode = '+234';
  final double _subTotal = 0;
  double _totalPrice = 0;
  double deliveryFee = 700;
  double serviceFee = 0;
  String? _userFirstName;
  String? _userLastName;
  String? _userEmail;
  final String _paymentDescription = "Benji app delivery";
  final String _currency = "NGN";

  // double insuranceFee = 0;
  // double discountFee = 0;
  _getTotalPrice() {
    _totalPrice = _subTotal + deliveryFee + serviceFee;
  }

  final List<String> _titles = <String>[
    "Status",
    "Sender's name",
    "Sender's phone number",
    "Receiver's name",
    "Receiver's phone number",
    "Receiver's location",
    "Item name",
    "Item quantity",
    "Item weight",
    "Item value",
  ];
  List<String>? _packageData;

  //===================== GlobalKeys =======================\\

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //===================== CONTROLLERS =======================\\

  final ScrollController _scrollController = ScrollController();

  //===================== BOOL VALUES =======================\\

  bool _isScrollToTopBtnVisible = false;
  bool _processingRequest = false;

  //===================== FUNCTIONS =======================\\

  Future<bool> createDeliveryItem({
    required clientId,
    required pickUpAddress,
    required senderName,
    required senderPhoneNumber,
    required dropOffAddress,
    required receiverName,
    required receiverPhoneNumber,
    required itemName,
    required itemCategoryId,
    required itemWeightId,
    required itemQuantity,
    required itemValue,
  }) async {
    Map body = {
      'client_id': clientId,
      'pickUpAddress': pickUpAddress,
      'senderName': senderName,
      'senderPhoneNumber': senderPhoneNumber,
      'dropOffAddress': dropOffAddress,
      'receiverName': receiverName,
      'receiverPhoneNumber': receiverPhoneNumber,
      'itemName': itemName,
      'itemCategory_id': itemCategoryId,
      'itemWeight_id': itemWeightId,
      'itemQuantity': itemQuantity,
      'itemValue': itemValue,
    };

    final response = await http.post(
      Uri.parse('$baseURL/sendPackage/createItemPackage/'),
      body: body,
      headers: await authHeader(),
    );

    return response.statusCode == 200 && response.body == '"Package Created."';
  }

  _placeOrder() async {
    setState(() {
      _processingRequest = true;
    });
    await checkAuth(context);
    // User? user = await getUser();
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);

    Map<String, dynamic> monnifyPayload() {
      return {
        "amount": _totalPrice,
        "currency": _currency,
        "reference": formattedDateAndTime,
        "customerFullName": "$_userFirstName $_userLastName",
        "customerEmail": "$_userEmail",
        "apiKey": monnifyApiKey,
        "contractCode": monnifyContractCode,
        "paymentDescription": _paymentDescription,
        "final metadata": {"name": "$_userFirstName", "age": 23},
        // "incomeSplitConfig": [
        //   {
        //     "subAccountCode": "MFY_SUB_342113621921",
        //     "feePercentage": 50,
        //     "splitAmount": 1900,
        //     "feeBearer": true
        //   },
        //   {
        //     "subAccountCode": "MFY_SUB_342113621922",
        //     "feePercentage": 50,
        //     "splitAmount": 2100,
        //     "feeBearer": true
        //   }
        // ],
        "paymentMethod": ["CARD", "ACCOUNT_TRANSFER", "USSD", "PHONE_NUMBER"],
      };
    }

    TransactionResponse? response = await Monnify().checkout(
      context,
      monnifyPayload(),
      appBar: AppBarConfig(
          titleColor: kPrimaryColor, backgroundColor: kAccentColor),
      toast: ToastConfig(color: kBlackColor, backgroundColor: kAccentColor),
      displayToast: false,
    );
    //     .then(
    //   (value) async {
    //     bool res = await createDeliveryItem(
    //       clientId: user!.id.toString(),
    //       dropOffAddress: widget.receiverLocation,
    //       itemCategoryId: widget.itemCategoryId,
    //       itemName: widget.itemName,
    //       itemQuantity: widget.itemQuantity,
    //       itemValue: widget.itemValue,
    //       itemWeightId: widget.itemWeight,
    //       pickUpAddress: widget.receiverLocation,
    //       receiverName: widget.receiverName,
    //       receiverPhoneNumber: '+$countryDialCode${widget.receiverPhoneNumber}',
    //       senderName: widget.senderName,
    //       senderPhoneNumber: '+$countryDialCode${widget.receiverPhoneNumber}',
    //     );
    //     if (res) {
    //       mySnackBar(
    //         context,
    //         kSuccessColor,
    //         "Success!",
    //         "Your delivery request has been submitted",
    //         const Duration(seconds: 2),
    //       );

    //       setState(() {
    //         _processingRequest = false;
    //       });
    //       Get.to(
    //         () => const ChooseRider(),
    //         routeName: 'ChooseRider',
    //         duration: const Duration(milliseconds: 300),
    //         fullscreenDialog: true,
    //         curve: Curves.easeIn,
    //         preventDuplicates: true,
    //         popGesture: true,
    //         transition: Transition.rightToLeft,
    //       );
    //     } else {
    //       mySnackBar(
    //         context,
    //         kErrorColor,
    //         "Failed!",
    //         "Failed to submit",
    //         const Duration(seconds: 2),
    //       );
    //       setState(() {
    //         _processingRequest = false;
    //       });
    //     }
    //   },
    // );

    //call the backend to verify transaction status before providing value
    if (kDebugMode) {
      print("Future completed======>${response?.toJson().toString()}");
      print("Future completed11======>${response?.message.toString()}");
    }
  }

  //===================== Scroll to Top ==========================\\
  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrollToTopBtnVisible = false;
    });
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >= 200 &&
        _isScrollToTopBtnVisible != true) {
      setState(() {
        _isScrollToTopBtnVisible = true;
      });
    }
    if (_scrollController.position.pixels < 200 &&
        _isScrollToTopBtnVisible == true) {
      setState(() {
        _isScrollToTopBtnVisible = false;
      });
    }
  }

  _getUserData() async {
    checkAuth(context);
    User? user = await getUser();
    setState(() {
      _userFirstName = user!.firstName!;
      _userLastName = user.lastName!;
      _userEmail = user.email!;
    });
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(
          title: "Payout",
          elevation: 0,
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
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        floatingActionButton: _isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                mini: deviceType(media.width) > 2 ? false : true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                Lottie.asset(
                  "assets/animations/delivery/frame_2.json",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
                kSizedBox,
                const Text(
                  'Package Summary',
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                kSizedBox,
                Container(
                  width: media.width,
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
                      ListView.separated(
                        itemCount: _titles.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 1,
                          color: kGreyColor,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 100,
                            width: media.width / 3,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: kLightGreyColor),
                            child: Text(
                              _titles[index],
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: media.width / 2,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              _packageData![index],
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 12,
                                fontFamily: 'sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          kSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Service Fee',
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '₦${formattedText(serviceFee)}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                _processingRequest
                    ? Center(
                        child: SpinKitChasingDots(
                          color: kAccentColor,
                          duration: const Duration(seconds: 1),
                        ),
                      )
                    : MyElevatedButton(
                        title: "Pay - ₦${formattedText(_totalPrice)}",
                        onPressed: () {
                          _placeOrder();
                        },
                      ),
                kSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
