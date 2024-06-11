// ignore_for_file: use_build_context_synchronously

import 'package:benji/app/rider/check_for_available_rider_for_package_delivery.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/components/button/my_outlined_elevatedbutton.dart';
import '../../src/components/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

class DeliverTo extends StatefulWidget {
  final int index;
  final Map<String, dynamic> formatOfOrder;
  const DeliverTo(
      {super.key, required this.formatOfOrder, required this.index});

  @override
  State<DeliverTo> createState() => _DeliverToState();
}

class _DeliverToState extends State<DeliverTo> {
  //===================== STATES =======================\\

  @override
  void initState() {
    super.initState();
    // _getData();
    formatOfOrder = widget.formatOfOrder;
    _currentOption = AddressController.instance.current.value;
  }

  //========================================================================\\

  //=================================== ALL VARIABLES =====================================\\
  Map? addressData;

  //=========================== BOOL VALUES ====================================\\
  bool _isLoading = false;

  Address? _currentOption;
  late Map<String, dynamic> formatOfOrder;

  //===================== CONTROLLERS =======================\\
  final _scrollController = ScrollController();

  //===================================================================== FUNCTIONS =======================================================================\\

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      addressData = null;
    });

    // await _getData();
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
    AddressController.instance.getAdresses();
    AddressController.instance.getCurrentAddress().then((value) {
      _currentOption = AddressController.instance.current.value;
    });
    // await _getData();
  }
  //===================== FUNCTIONS =======================\\

  Future<void> applyDeliveryAddress(Address? address) async {
    setState(() {
      _isLoading = true;
    });

    if (_currentOption == null) {
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
      // await _getData();
    }
    try {
      setCurrentAddress(address!.id);

      // here i need to create that order by sending it to the backend

      formatOfOrder['delivery_address_id'] = address.id;
      formatOfOrder['latitude'] = address.latitude;
      formatOfOrder['longitude'] = address.longitude;

      if (kDebugMode) {
        print('it $formatOfOrder');
      }
      //not after adding the address now post it to the endpoint
      String orderID =
          await OrderController.instance.createOrder([formatOfOrder]);
      // need to check if the order was created and get the delivery fee

      Get.to(
        () => CheckForAvailableRiderForPackageDelivery(
          isPackageDelivery: false,
          formatOfOrder: formatOfOrder,
          orderID: orderID,
          index: widget.index,
          deliverTo: address,
        ),
        routeName: 'check-for-available-rider',
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

      // Get.to(
      //   () => CheckoutScreen(
      //     formatOfOrder: formatOfOrder,
      //     orderID: orderID,
      //     index: widget.index,
      //     deliverTo: address,
      //   ),
      //   routeName: 'CheckoutScreen',
      //   duration: const Duration(milliseconds: 300),
      //   fullscreenDialog: true,
      //   curve: Curves.easeIn,
      //   popGesture: true,
      //   transition: Transition.rightToLeft,
      // );
    } catch (e) {
      mySnackBar(
        context,
        kAccentColor,
        "No address selected!",
        "Select address to add as default or add address",
        const Duration(
          seconds: 2,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: GetBuilder<AddressController>(
          initState: (state) {
            AddressController.instance.getAdresses();
            AddressController.instance.getCurrentAddress();
          },
          builder: (controller) {
            if (controller.isLoad.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: kAccentColor,
              ));
            }

            return SafeArea(
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
                        controller.addresses.isEmpty
                            ? const EmptyCard(
                                showButton: false,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.addresses.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: kDefaultPadding / 2,
                                    ),
                                    child: RadioListTile(
                                      value: controller.addresses[index].id,
                                      groupValue: _currentOption?.id ?? '',
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
                                                controller.addresses[index];
                                          },
                                        );
                                      }),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            // width: min(
                                            //     media.width - 150,
                                            //     20.0 *
                                            //         controller.addresses[index]
                                            //             .title.length),
                                            child: Text(
                                              controller.addresses[index].title
                                                  .toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          kWidthSizedBox,
                                          _currentOption?.id !=
                                                  (controller.addresses[index])
                                                      .id
                                              ? const SizedBox()
                                              : Container(
                                                  width: 65,
                                                  height: 24,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFFFFCFCF),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                          controller.addresses[index].details,
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
                    controller.addresses.isEmpty
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
            );
          },
        ),
      ),
    );
  }
}
