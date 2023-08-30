import 'package:benji_user/app/address/edit_address_details.dart';
import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/user/address_model.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  //==================================================== INITIAL STATE ======================================================\\
  @override
  void initState() {
    super.initState();
    _getData();
  }

  //============================================================ ALL VARIABLES ===================================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  ScrollController _scrollController = ScrollController();

  //================================================= RADIO LIST TILE ===================================================\\
  Map? addressData;

  _getData() async {
    await checkAuth(context);

    String current = '';
    try {
      current = (await getCurrentAddress()).id ?? '';
    } catch (e) {
      current = '';
    }
    List<Address> addresses = await getAddressesByUser();

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

  //========================================================================\\

  //======================================= Navigation ==========================================\\

  void _toEditAddressDetails() => Get.to(
        () => const EditAddressDetails(),
        routeName: 'EditAddressDetails',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toAddNewAddress() => Get.to(
        () => const AddNewAddress(),
        routeName: 'AddNewAddress',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    // double mediaHeight = MediaQuery.of(context).size.height;
    // double mediaWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: kAccentColor,
      edgeOffset: 0,
      displacement: kDefaultPadding,
      semanticsLabel: "Pull to refresh",
      strokeWidth: 4,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Addresses",
          toolbarHeight: kToolbarHeight,
          backgroundColor: kPrimaryColor,
          actions: [],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: MyElevatedButton(
            title: "Add new address",
            onPressed: _toAddNewAddress,
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: addressData == null
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: (addressData!['addresses'] as List<Address>).isEmpty
                      ? EmptyCard()
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: addressData!['addresses'].length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                vertical: kDefaultPadding / 2,
                              ),
                              child: ListTile(
                                onTap: _toEditAddressDetails,
                                enableFeedback: true,
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: kAccentColor,
                                ),
                                title: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressData!['addresses'][index]
                                                .title
                                                .toUpperCase() ??
                                            '',
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      kWidthSizedBox,
                                      addressData!['current'] ==
                                              addressData!['addresses'][index]
                                                  .id
                                          ? Container(
                                              width: 58,
                                              height: 24,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: ShapeDecoration(
                                                color: kAccentColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                    'Default',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
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
                                              .streetAddress ??
                                          '',
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ),
      ),
    );
  }
}
