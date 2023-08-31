import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/textformfield/my textformfield.dart';
import '../../src/common_widgets/textformfield/my_intl_phonefield.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class EditAddressDetails extends StatefulWidget {
  const EditAddressDetails({super.key});

  @override
  State<EditAddressDetails> createState() => _EditAddressDetailsState();
}

class _EditAddressDetailsState extends State<EditAddressDetails> {
  //=================================== ALL VARIABLES =====================================\\

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();
  final _cscPickerKey = GlobalKey<CSCPickerState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController _addressTitleEC = TextEditingController();
  TextEditingController _streetAddressEC = TextEditingController();
  TextEditingController _apartmentDetailsEC = TextEditingController();
  TextEditingController _phoneNumberEC = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode _addressTitleFN = FocusNode();
  FocusNode _streetAddressFN = FocusNode();
  FocusNode _apartmentDetailsFN = FocusNode();
  FocusNode _phoneNumberFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Edit Address",
          toolbarHeight: kToolbarHeight,
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
              onPressed: () {
                _addressTitleFN.requestFocus();
              },
              icon: FaIcon(
                FontAwesomeIcons.solidPenToSquare,
                color: kAccentColor,
                size: 18,
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title (My Home, My Office)',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        kHalfSizedBox,
                        MyTextFormField(
                          hintText: "30 Crescent Lane, Lagos",
                          controller: _addressTitleEC,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          focusNode: _addressTitleFN,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              _addressTitleFN.requestFocus();
                              return "Enter a title";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addressTitleEC.text = value!;
                          },
                        ),
                        kHalfSizedBox,
                        Text(
                          'Name tag of this address e.g my work, my apartment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Street Address',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHalfSizedBox,
                          MyTextFormField(
                            hintText: "Crescent Lane, Surrulere,  Lagos",
                            controller: _streetAddressEC,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.streetAddress,
                            focusNode: _streetAddressFN,
                            validator: (value) {
                              RegExp streetAddressPattern = RegExp(r'^.{4,}$');

                              if (value == null || value!.isEmpty) {
                                _streetAddressFN.requestFocus();
                                return "Enter your street address";
                              } else if (!streetAddressPattern
                                  .hasMatch(value)) {
                                _streetAddressFN.requestFocus();
                                return "Please enter a valid street address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _streetAddressEC.text = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Details (Door, Apartment Number)',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHalfSizedBox,
                          MyTextFormField(
                            hintText: "Flat 4",
                            controller: _apartmentDetailsEC,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            focusNode: _apartmentDetailsFN,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                _apartmentDetailsFN.requestFocus();
                                return "Enter your apartment detail";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _apartmentDetailsEC.text = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHalfSizedBox,
                          MyIntlPhoneField(
                            initialCountryCode: "NG",
                            invalidNumberMessage: "Invalid phone number",
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: true,
                            showDropdownIcon: true,
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: kAccentColor,
                            ),
                            controller: _phoneNumberEC,
                            textInputAction: TextInputAction.next,
                            focusNode: _phoneNumberFN,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                _phoneNumberFN.requestFocus();
                                return "Enter your phone number";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _phoneNumberEC.text = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Localization',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHalfSizedBox,
                          CSCPicker(
                            key: _cscPickerKey,
                            layout: Layout.vertical,
                            countryDropdownLabel: "Select country",
                            stateDropdownLabel: "Select state",
                            cityDropdownLabel: "Select city",
                            currentCountry: "Nigeria",
                            onCountryChanged: (country) {
                              country = country;
                            },
                            onStateChanged: (state) {
                              state = state;
                            },
                            onCityChanged: (city) {
                              city = city;
                            },
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                  ],
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              MyOutlinedElevatedButton(
                title: "Set As Default Address",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Get.back();
                    mySnackBar(
                      context,
                      kSuccessColor,
                      "Success!",
                      "Set As Default Address",
                      Duration(seconds: 2),
                    );
                  }
                }),
              ),
              kSizedBox,
              MyElevatedButton(
                title: "Save changes",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Get.back();
                    mySnackBar(
                      context,
                      kSuccessColor,
                      "Success!",
                      "Changes saved",
                      Duration(seconds: 2),
                    );
                  }
                }),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
