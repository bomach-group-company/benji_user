import 'package:benji/app/address/add_new_address.dart';
import 'package:benji/app/address/edit_address_details.dart';
import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/address/address_model.dart';
import '../../theme/colors.dart';

class MyCarts extends StatefulWidget {
  const MyCarts({super.key});

  @override
  State<MyCarts> createState() => _MyCartsState();
}

class _MyCartsState extends State<MyCarts> {
  //==================================================== INITIAL STATE ======================================================\\
  @override
  void initState() {
    super.initState();
  }

  //============================================================ ALL VARIABLES ===================================================================\\

  //============================================================ BOOL VALUES ===================================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final ScrollController _scrollController = ScrollController();

  //================================================= Logic ===================================================\\

  //=================================================================================================\\

  //================================================================== FUNCTIONS ====================================================================\\

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {}

  //========================================================================\\

  //======================================= Navigation ==========================================\\

  void _pickOption(Address address) => Get.defaultDialog(
        title: "What do you want to do?",
        titleStyle: const TextStyle(
          fontSize: 20,
          color: kTextBlackColor,
          fontWeight: FontWeight.w700,
        ),
        content: const SizedBox(height: 0),
        cancel: ElevatedButton(
          onPressed: () => _deleteAddress(address.id),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: kAccentColor),
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: kBlackColor.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.solidTrashCan, color: kAccentColor),
              kHalfWidthSizedBox,
              Text(
                "Delete",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        confirm: ElevatedButton(
          onPressed: () => _toEditAddressDetails(address),
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccentColor,
            elevation: 10.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: kBlackColor.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.solidPenToSquare, color: kPrimaryColor),
              kHalfSizedBox,
              Text(
                "Edit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );

  void _deleteAddress(String addressId) async {
    await deleteAddress(addressId);
    Get.back();
    await AddressController.instance.refreshData();
  }

  void _toEditAddressDetails(Address address) async {
    await Get.off(
      () => EditAddressDetails(address: address),
      routeName: 'EditAddressDetails',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    await AddressController.instance.refreshData();
  }

  void _toAddNewAddress() async {
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
    await AddressController.instance.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    // double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
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
          title: "My Carts",
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: GetBuilder<AddressController>(
              initState: (state) => AddressController.instance.getAdresses(),
              builder: (controller) {
                if (controller.isLoad.value && controller.addresses.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  );
                }
                return Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: controller.addresses.isEmpty
                      ? const EmptyCard(removeButton: true)
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: controller.addresses.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: kDefaultPadding / 2,
                              ),
                              child: ListTile(
                                onTap: () =>
                                    _pickOption(controller.addresses[index]),
                                enableFeedback: true,
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: kAccentColor,
                                ),
                                title: SizedBox(
                                  width: mediaWidth - 100,
                                  child: Text(
                                    'Cart ${index + 1}',
                                    style: const TextStyle(
                                      color: kTextBlackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              }),
        ),
      ),
    );
  }
}
