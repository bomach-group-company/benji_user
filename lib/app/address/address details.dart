import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20outlined%20elevatedbutton.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../modules/my floating snackbar.dart';
import '../../reusable widgets/my textformfield.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  //=================================== ALL VARIABLES =====================================\\

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();
  final _cscPickerKey = GlobalKey<CSCPickerState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentDetailsController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode addressTitleFocusNode = FocusNode();
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
          title: "Edit Address ",
          backgroundColor: kPrimaryColor,
          actions: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/icons/edit-icon.png",
                  ),
                ),
              ),
            )
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
                              hintText: "30 Crescent Lane, Lagos",
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
                                }
                                if (!streetAddressPattern.hasMatch(value)) {
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
                              hintText: "Flat 4",
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
                              hintText: "+2347025479571",
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
                                }
                                if (!nigeriaPhoneNumberPattern
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
                title: "Save changes",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(context);
                    mySnackBar(
                      context,
                      "Changes saved",
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
