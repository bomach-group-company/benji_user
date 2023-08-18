import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/providers/constants.dart';
import '../../src/common_widgets/my_appbar.dart';
import '../../src/common_widgets/my_elevatedbutton.dart';
import '../../src/common_widgets/my_floating_snackbar.dart';
import '../../src/common_widgets/my_intl_phonefield.dart';
import '../../src/common_widgets/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/my_textformfield.dart';
import '../../theme/colors.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  //=================================== ALL VARIABLES =====================================\\

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();
  final _cscPickerKey = GlobalKey<CSCPickerState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController addressTitleEC = TextEditingController();
  TextEditingController recipientNameEC = TextEditingController();
  TextEditingController streetAddressEC = TextEditingController();
  TextEditingController apartmentDetailsEC = TextEditingController();
  TextEditingController phoneNumberEC = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode addressTitleFN = FocusNode();
  FocusNode recipientNameFN = FocusNode();
  FocusNode streetAddressFN = FocusNode();
  FocusNode apartmentDetailsFN = FocusNode();
  FocusNode phoneNumberFN = FocusNode();

  //===================== BOOL VALUES =======================\\
  bool isLoading = false;
  bool isLoading2 = false;

  //===================== FUNCTIONS =======================\\
  //SET DEFAULT ADDRESS
  Future<void> setDefaultAddress() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay
    await Future.delayed(Duration(seconds: 1));

    //Display snackBar\
    mySnackBar(
      context,
      "Success!",
      "Set As Default Address",
      Duration(seconds: 2),
    );

    // Future.delayed(
    //     const Duration(
    //       seconds: 1,
    //     ), () {
    //   // Navigate to the new page
    //   Navigator.of(context).pop(context);
    // });

    setState(() {
      isLoading = false;
    });
  }

  //SAVE NEW ADDRESS
  Future<void> saveNewAddress() async {
    setState(() {
      isLoading2 = true;
    });

    // Simulating a delay
    await Future.delayed(Duration(seconds: 1));

    //Display snackBar\
    mySnackBar(
      context,
      "Success!",
      "Address saved",
      Duration(seconds: 2),
    );
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      // Navigate to the new page
      Navigator.of(context).pop(context);
    });

    setState(() {
      isLoading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "New Address ",
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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
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
                              hintText:
                                  "Enter address name tag e.g my work, my home....",
                              controller: addressTitleEC,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: addressTitleFN,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  addressTitleFN.requestFocus();
                                  return "Enter a title";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                addressTitleEC.text = value!;
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
                      ),
                      kSizedBox,
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recipient Name',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "Enter recipient name",
                              controller: recipientNameEC,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: recipientNameFN,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFN.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  recipientNameFN.requestFocus();
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameEC.text = value!;
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
                              'Street Address',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "E.g 123 Main Street",
                              controller: streetAddressEC,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.streetAddress,
                              focusNode: streetAddressFN,
                              validator: (value) {
                                RegExp streetAddressPattern = RegExp(
                                  r'^\d+\s+[a-zA-Z0-9\s.-]+$',
                                );
                                ;
                                if (value == null || value!.isEmpty) {
                                  streetAddressFN.requestFocus();
                                  return "Enter your street address";
                                } else if (!streetAddressPattern
                                    .hasMatch(value)) {
                                  streetAddressFN.requestFocus();
                                  return "Please enter a valid street address (Must have a number)";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                streetAddressEC.text = value!;
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
                              hintText: "E.g Suite B3",
                              controller: apartmentDetailsEC,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              focusNode: apartmentDetailsFN,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  apartmentDetailsFN.requestFocus();
                                  return "Enter your apartment detail";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                apartmentDetailsEC.text = value!;
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
                              controller: phoneNumberEC,
                              textInputAction: TextInputAction.next,
                              focusNode: phoneNumberFN,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  phoneNumberFN.requestFocus();
                                  return "Enter your phone number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phoneNumberEC.text = value;
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
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              isLoading
                  ? Center(
                      child: SpinKitChasingDots(
                        color: kAccentColor,
                        duration: const Duration(seconds: 1),
                      ),
                    )
                  : MyOutlinedElevatedButton(
                      title: "Set As Default Address",
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          setDefaultAddress();
                        }
                      }),
                    ),
              kSizedBox,
              isLoading2
                  ? Center(
                      child: SpinKitChasingDots(
                        color: kAccentColor,
                        duration: const Duration(seconds: 1),
                      ),
                    )
                  : MyElevatedButton(
                      title: "Save New Address",
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          saveNewAddress();
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
