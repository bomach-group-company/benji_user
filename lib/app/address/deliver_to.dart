import 'package:benji_user/app/checkout/checkout_screen.dart';
import 'package:benji_user/src/repo/models/user/address_model.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

class DeliverTo extends StatefulWidget {
  final bool toCheckout;
  final bool inCheckout;
  const DeliverTo(
      {super.key, this.toCheckout = false, this.inCheckout = false});

  @override
  State<DeliverTo> createState() => _DeliverToState();
}

class _DeliverToState extends State<DeliverTo> {
  //=================================== ALL VARIABLES =====================================\\

  //=========================== BOOL VALUES ====================================\\
  bool isLoading = false;

  String currentOption = '';

  //===================== STATES =======================\\

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map? addressData;

  _getData() async {
    await checkAuth(context);

    String current = '';
    try {
      current = (await getCurrentAddress()).id ?? '';
    } catch (e) {
      current = '';
    }
    currentOption = current;
    List<Address> addresses = await getAddressesByUser();

    Address? itemToMove =
        addresses.firstWhere((elem) => elem.id == current, orElse: null);

    addresses.remove(itemToMove);
    addresses.insert(0, itemToMove);

    Map data = {
      'current': current,
      'addresses': addresses,
    };

    setState(() {
      addressData = data;
    });
  }

  //=================================================================================================\\

  //===================================================================== FUNCTIONS =======================================================================\\

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      addressData = null;
    });

    await _getData();
  }

  //===================== FUNCTIONS =======================\\

  Future<void> applyDeliveryAddress(String addressId) async {
    setState(() {
      isLoading = true;
    });

    Address address = await setCurrentAddress(addressId);

    if (!widget.toCheckout) {
      //Display snackBar
      mySnackBar(
        context,
        kSuccessColor,
        "Succcess!",
        "Delivery address updated",
        Duration(
          seconds: 2,
        ),
      );
    }

    if (widget.toCheckout) {
      if (widget.inCheckout) {
        Get.close(1);
      } else {
        Get.off(
          () => CheckoutScreen(deliverTo: address),
          routeName: 'CheckoutScreen',
          duration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          popGesture: true,
          transition: Transition.rightToLeft,
        );
      }
    } else {
      Get.back();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Deliver to ",
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: addressData == null
            ? Center(child: SpinKitChasingDots(color: kAccentColor))
            : ListView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: addressData!['addresses'].length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                vertical: kDefaultPadding / 2,
                              ),
                              child: RadioListTile(
                                value: addressData!['addresses'][index].id,
                                groupValue: currentOption,
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
                                      currentOption =
                                          addressData!['addresses'][index].id;
                                    },
                                  );
                                }),
                                title: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressData!['addresses'][index].title,
                                        style: TextStyle(
                                          color: Color(
                                            0xFF151515,
                                          ),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      kWidthSizedBox,
                                      Container(
                                        width: 58,
                                        height: 24,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: currentOption ==
                                                  addressData!['addresses']
                                                          [index]
                                                      .id
                                              ? Color(
                                                  0xFFFFCFCF,
                                                )
                                              : Color(
                                                  0x00000000,
                                                ),
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
                                              currentOption ==
                                                      addressData!['addresses']
                                                              [index]
                                                          .id
                                                  ? 'Default'
                                                  : '',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: kAccentColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: kDefaultPadding / 2,
                                  ),
                                  child: Container(
                                    child: Text(
                                      addressData!['addresses'][index]
                                          .streetAddress,
                                      style: TextStyle(
                                        color: Color(
                                          0xFF4C4C4C,
                                        ),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                    ],
                  ),
                  MyOutlinedElevatedButton(
                    title: "Add New Address",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddNewAddress(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  isLoading
                      ? Center(
                          child: SpinKitChasingDots(
                            color: kAccentColor,
                            duration: const Duration(seconds: 1),
                          ),
                        )
                      : MyElevatedButton(
                          title: "Apply",
                          onPressed: () {
                            applyDeliveryAddress(currentOption);
                          },
                        ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                ],
              ),
      ),
    );
  }
}
