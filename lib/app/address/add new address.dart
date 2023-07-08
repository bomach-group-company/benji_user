import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20outlined%20elevatedbutton.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../modules/my floating snackbar.dart';
import '../../reusable widgets/my textformfield.dart';
import '../../theme/colors.dart';
import '../../providers/constants.dart';

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
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentDetailsController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode addressTitleFocusNode = FocusNode();
  FocusNode recipientNameFocusNode = FocusNode();
  FocusNode streetAddressFocusNode = FocusNode();
  FocusNode apartmentDetailsFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "New Address ",
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
                              controller: addressTitleController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: addressTitleFocusNode,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  addressTitleFocusNode.requestFocus();
                                  return "Enter a title";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                addressTitleController.text = value!;
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
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: recipientNameFocusNode,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameController.text = value!;
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
                              controller: streetAddressController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.streetAddress,
                              focusNode: streetAddressFocusNode,
                              validator: (value) {
                                RegExp streetAddressPattern = RegExp(
                                  r'^\d+\s+[a-zA-Z0-9\s.-]+$',
                                );
                                ;
                                if (value == null || value!.isEmpty) {
                                  streetAddressFocusNode.requestFocus();
                                  return "Enter your street address";
                                } else if (!streetAddressPattern
                                    .hasMatch(value)) {
                                  streetAddressFocusNode.requestFocus();
                                  return "Please enter a valid street address";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                streetAddressController.text = value!;
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
                              controller: apartmentDetailsController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              focusNode: apartmentDetailsFocusNode,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  apartmentDetailsFocusNode.requestFocus();
                                  return "Enter your apartment detail";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                apartmentDetailsController.text = value!;
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
                            MyTextFormField(
                              hintText: "+234",
                              controller: phoneNumberController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                              focusNode: phoneNumberFocusNode,
                              validator: (value) {
                                RegExp nigeriaPhoneNumberPattern = RegExp(
                                  r'^\+?[0-9\s-]+$',
                                );
                                String phoneNumber = '+1 123-456-7890';
                                if (value == null || value!.isEmpty) {
                                  phoneNumberFocusNode.requestFocus();
                                  return "Enter your phone number";
                                } else if (!nigeriaPhoneNumberPattern
                                    .hasMatch(phoneNumber)) {
                                  phoneNumberFocusNode.requestFocus();
                                  return "Please enter a valid phone number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phoneNumberController.text = value;
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
              MyOutlinedElevatedButton(
                title: "Set As Default Address",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(context);
                    mySnackBar(
                      context,
                      "Set As Default Address",
                      kAccentColor,
                      SnackBarBehavior.floating,
                      kDefaultPadding,
                    );
                  }
                }),
              ),
              kSizedBox,
              MyElevatedButton(
                title: "Save New Address",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(context);
                    mySnackBar(
                      context,
                      "Address saved",
                      kAccentColor,
                      SnackBarBehavior.floating,
                      kDefaultPadding,
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
