// ignore_for_file: invalid_use_of_protected_member

import 'package:benji/app/address/get_location_on_map.dart';
import 'package:benji/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji/src/common_widgets/textformfield/my%20textformfield.dart';
import 'package:benji/src/common_widgets/textformfield/my_maps_textformfield.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/providers/controllers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CRMTab extends StatefulWidget {
  const CRMTab({super.key});

  @override
  State<CRMTab> createState() => _CRMTabState();
}

class _CRMTabState extends State<CRMTab> {
  // variales
  String? latitudePick;

  String? longitudePick;

  String? latitudeDrop;

  String? longitudeDrop;

  // controller
  final TextEditingController _nameEC = TextEditingController();
  final TextEditingController _userEmailEC = TextEditingController();
  final TextEditingController _phonenumberEC = TextEditingController();
  // final TextEditingController _businessNameEC = TextEditingController();
  // final TextEditingController _businessRegNoEC = TextEditingController();
  // final TextEditingController _businessTypeEC = TextEditingController();
  final TextEditingController _locationEC = TextEditingController();

  // final TextEditingController _nameEC = TextEditingController();
  final LatLngDetailController latLngDetailController =
      Get.put(LatLngDetailController());

  // Focus node
  final FocusNode _nameFN = FocusNode();
  final FocusNode _userEmailFN = FocusNode();
  final FocusNode _phonenumberFN = FocusNode();
  // final FocusNode _businessNameFN = FocusNode();
  // final FocusNode _businessRegNoFN = FocusNode();
  // final FocusNode _businessTypeFN = FocusNode();
  final FocusNode _locationFN = FocusNode();

  // final FocusNode _nameFN = FocusNode();
  void _toGetLocationOnMapDrop() async {
    await Get.to(
      () => const GetLocationOnMap(),
      routeName: 'GetLocationOnMap',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    latitudeDrop = latLngDetailController.latLngDetail.value[0];
    longitudeDrop = latLngDetailController.latLngDetail.value[1];
    _locationEC.text = latLngDetailController.latLngDetail.value[2];
    latLngDetailController.setEmpty();
    if (kDebugMode) {
      print("LATLNG: $latitudeDrop,$longitudeDrop");
      print(_locationEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kSizedBox,
        kSizedBox,
        const Text(
          'Full name',
          style: TextStyle(
            color: kTextBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        kHalfSizedBox,
        MyTextFormField(
          hintText: "Enter full name",
          textCapitalization: TextCapitalization.words,
          controller: _nameEC,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.name,
          focusNode: _nameFN,
          validator: (value) {
            RegExp pattern = RegExp(r'^.{3,}$');
            if (value == null || value!.isEmpty) {
              _nameFN.requestFocus();
              return "Enter a full name";
            } else if (!pattern.hasMatch(value)) {
              _nameFN.requestFocus();
              return "Please enter a valid name";
            }
            return null;
          },
          onSaved: (value) {
            _nameEC.text = value!;
          },
        ),
        kSizedBox,
        const Text(
          'Email Address',
          style: TextStyle(
            color: kTextBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        kHalfSizedBox,
        MyTextFormField(
          hintText: "Eg. johndoe@gmail.com",
          textCapitalization: TextCapitalization.words,
          controller: _userEmailEC,
          focusNode: _userEmailFN,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.name,
          validator: (value) {
            RegExp emailPattern = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
            );
            if (value == null || value!.isEmpty) {
              _userEmailFN.requestFocus();
              return "Enter your email address";
            } else if (!emailPattern.hasMatch(value)) {
              _userEmailFN.requestFocus();
              return "Please enter a valid email address";
            }
            return null;
          },
          onSaved: (value) {
            _userEmailEC.text = value;
          },
        ),
        kSizedBox,
        const Text(
          'Phone number',
          style: TextStyle(
            color: kTextBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        kHalfSizedBox,
        MyTextFormField(
          hintText: "eg. +2349077457301",
          textCapitalization: TextCapitalization.words,
          controller: _phonenumberEC,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.name,
          focusNode: _phonenumberFN,
          validator: (value) {
            RegExp pattern = RegExp(r'^\d{10}$');
            if (value == null || value!.isEmpty) {
              _phonenumberFN.requestFocus();
              return "Enter a phone number";
            } else if (!pattern.hasMatch(value)) {
              _phonenumberFN.requestFocus();
              return "Please enter a valid phone number";
            }
            return null;
          },
          onSaved: (value) {
            _phonenumberEC.text = value!;
          },
        ),
        kSizedBox,
        const Text(
          'Address',
          style: TextStyle(
            color: kTextBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        kHalfSizedBox,
        MyMapsTextFormField(
          readOnly: true,
          controller: _locationEC,
          validator: (value) {
            RegExp pickupAddress = RegExp(r'^\d+\s+[a-zA-Z0-9\s.-]+$');
            if (value!.isEmpty || value == null) {
              _locationFN.requestFocus();
              return "Enter drop-off location";
            } else if (!pickupAddress.hasMatch(value)) {
              _locationFN.requestFocus();
              return "Enter a valid address (must have a street number)";
            }
            return null;
          },
          onSaved: (value) {
            _locationEC.text = value;
          },
          textInputAction: TextInputAction.done,
          focusNode: _locationFN,
          hintText: "Pick location",
          textInputType: TextInputType.text,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: FaIcon(
              FontAwesomeIcons.locationDot,
              color: kAccentColor,
              size: 18,
            ),
          ),
        ),
        kSizedBox,
        Divider(
          height: 10,
          thickness: 2,
          color: kLightGreyColor,
        ),
        ElevatedButton.icon(
          onPressed: _toGetLocationOnMapDrop,
          icon: FaIcon(
            FontAwesomeIcons.locationArrow,
            color: kAccentColor,
            size: 18,
          ),
          label: const Text("Locate on map"),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kLightGreyColor,
            foregroundColor: kTextBlackColor,
            fixedSize: Size(media.width, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        kSizedBox,
        kHalfSizedBox,
        MyElevatedButton(
          title: "Submit",
          onPressed: () {},
        ),
        kSizedBox,
      ],
    );
  }
}
