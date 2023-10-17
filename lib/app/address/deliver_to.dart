// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:benji/app/checkout/checkout_screen.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/components/button/my_outlined_elevatedbutton.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

class DeliverTo extends StatefulWidget {
  final List<Map<String, dynamic>> formatOfOrder;
  final bool inCheckout;
  const DeliverTo(
      {super.key, required this.formatOfOrder, this.inCheckout = false});

  @override
  State<DeliverTo> createState() => _DeliverToState();
}

class _DeliverToState extends State<DeliverTo> {
  //===================== STATES =======================\\

  @override
  void initState() {
    super.initState();
    _getData();
    formatOfOrder = widget.formatOfOrder;
  }

  //========================================================================\\

  //=================================== ALL VARIABLES =====================================\\
  Map? _addressData;

  //=========================== BOOL VALUES ====================================\\
  bool _isLoading = false;

  String _currentOption = '';
  late List<Map<String, dynamic>> formatOfOrder;

  //===================== CONTROLLERS =======================\\
  final _scrollController = ScrollController();

  //===================================================================== FUNCTIONS =======================================================================\\

  _getData() async {
    String current = '';
    try {
      current = (await getCurrentAddress()).id ?? '';
    } catch (e) {
      current = '';
    }
    _currentOption = current;
    List<Address> addresses = await getAddressesByUser();

    if (current != '') {
      Address? itemToMove = addresses.firstWhere(
        (elem) => elem.id == current,
      );

      addresses.remove(itemToMove);
      addresses.insert(0, itemToMove);
    }
    Map data = {
      'current': current,
      'addresses': addresses,
    };

    setState(() {
      _addressData = data;
    });
  }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _addressData = null;
    });

    await _getData();
  }

  void _addAddress() async {
    await Get.to(
      () => const AddNewAddress(),
      routeName: 'AddNewAddress',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    await _getData();
  }
  //===================== FUNCTIONS =======================\\

  Future<void> applyDeliveryAddress(String addressId) async {
    setState(() {
      _isLoading = true;
    });

    if (_currentOption == '') {
      await Get.to(
        () => const AddNewAddress(),
        routeName: 'AddNewAddress',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
      await _getData();
    }
    // try {
    await setCurrentAddress(addressId);
    // here i need to create that order by sending it to the backend
    formatOfOrder.map((item) {
      item['delivery_address'] = addressId;
      return item;
    }).toList();
    if (kDebugMode) {
      print('it $formatOfOrder');
    }
    //not after adding the address now post it to the endpoint
    await createOrder(formatOfOrder);
    // need to check if the order was created and get the delivery fee
    if (widget.inCheckout) {
      Get.back();
    } else {
      Get.off(
        () => CheckoutScreen(formatOfOrder: formatOfOrder),
        routeName: 'CheckoutScreen',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    }
    // } catch (e) {
    //   mySnackBar(
    //     context,
    //     kAccentColor,
    //     "No address selected!",
    //     "Select address to add as default or add address",
    //     const Duration(
    //       seconds: 2,
    //     ),
    //   );
    // }

    // if (widget.toCheckout) {
    //   if (widget.inCheckout && address != null) {
    //     Get.close(1);
    //   } else {
    //     Get.off(
    //       () => CheckoutScreen(deliverTo: address!),
    //       routeName: 'CheckoutScreen',
    //       duration: const Duration(milliseconds: 300),
    //       fullscreenDialog: true,
    //       curve: Curves.easeIn,
    //       popGesture: true,
    //       transition: Transition.rightToLeft,
    //     );
    //   }
    // } else {
    //   Get.back();
    // }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Add a delivery location",
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: _addressData == null
            ? Center(
                child: CircularProgressIndicator(color: kAccentColor),
              )
            : SafeArea(
                maintainBottomViewPadding: true,
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    children: [
                      Column(
                        children: [
                          _addressData!['addresses']!.isEmpty
                              ? const EmptyCard(removeButton: true)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _addressData!['addresses'].length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                        vertical: kDefaultPadding / 2,
                                      ),
                                      child: RadioListTile(
                                        value: _addressData!['addresses'][index]
                                            .id,
                                        groupValue: _currentOption,
                                        activeColor: kAccentColor,
                                        enableFeedback: true,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        fillColor: MaterialStatePropertyAll(
                                          kAccentColor,
                                        ),
                                        onChanged: ((value) {
                                          setState(
                                            () {
                                              _currentOption =
                                                  _addressData!['addresses']
                                                          [index]
                                                      .id;
                                            },
                                          );
                                        }),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: min(
                                                  mediaWidth - 200,
                                                  15.0 *
                                                      _addressData!['addresses']
                                                              [index]
                                                          .title
                                                          .length),
                                              child: Text(
                                                _addressData!['addresses']
                                                        [index]
                                                    .title
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: kTextBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            kWidthSizedBox,
                                            _currentOption !=
                                                    _addressData!['addresses']
                                                            [index]
                                                        .id
                                                ? const SizedBox()
                                                : Container(
                                                    width: 60,
                                                    height: 24,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFFFCFCF),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Default',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: kAccentColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                            top: kDefaultPadding / 2,
                                          ),
                                          child: Text(
                                            _addressData!['addresses'][index]
                                                .details,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                          const SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                        ],
                      ),
                      MyOutlinedElevatedButton(
                        title: "Add New Address",
                        onPressed: _addAddress,
                      ),
                      const SizedBox(height: kDefaultPadding),
                      _addressData!['addresses']!.isEmpty
                          ? const SizedBox()
                          : _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: kAccentColor),
                                )
                              : MyElevatedButton(
                                  title: "Apply",
                                  onPressed: () {
                                    applyDeliveryAddress(_currentOption);
                                  },
                                ),
                      const SizedBox(height: kDefaultPadding * 2),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
