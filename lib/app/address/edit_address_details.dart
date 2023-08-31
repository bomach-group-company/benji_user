import 'package:benji_user/src/repo/models/address_model.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/textformfield/my textformfield.dart';
import '../../src/common_widgets/textformfield/my_intl_phonefield.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../src/repo/utils/base_url.dart';
import '../../theme/colors.dart';

class EditAddressDetails extends StatefulWidget {
  final Address address;
  const EditAddressDetails({super.key, required this.address});

  @override
  State<EditAddressDetails> createState() => _EditAddressDetailsState();
}

class _EditAddressDetailsState extends State<EditAddressDetails> {
  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();
  final _cscPickerKey = GlobalKey<CSCPickerState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController _addressTitleEC = TextEditingController();
  TextEditingController _recipientNameEC = TextEditingController();
  TextEditingController _streetAddressEC = TextEditingController();
  TextEditingController _apartmentDetailsEC = TextEditingController();
  TextEditingController _phoneNumberEC = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode _addressTitleFN = FocusNode();
  FocusNode _recipientNameFN = FocusNode();
  FocusNode _streetAddressFN = FocusNode();
  FocusNode _apartmentDetailsFN = FocusNode();
  FocusNode _phoneNumberFN = FocusNode();

  //===================== ALL VARIABLES =======================\\
  String? country;
  String? state;
  String? city;
  String countryDialCode = '';

  //===================== BOOL VALUES =======================\\
  bool _isLoading = false;
  bool _isLoading2 = false;

  //===================== FUNCTIONS =======================\\
  Future<bool> addAddress({bool is_current = true}) async {
    await checkAuth(context);
    final url =
        Uri.parse('$baseURL/address/changeAddressDetails/${widget.address.id}');
    List<String> countryList = country!.split(' ');
    final User user = (await getUser())!;

    final body = {
      'title': _addressTitleEC.text,
      'recipient_name': _recipientNameEC.text,
      'phone': "+$countryDialCode${_phoneNumberEC.text}",
      'street_address': _streetAddressEC.text,
      'details': _apartmentDetailsEC.text,
      'country': countryList[countryList.length - 1],
      'state': state,
      'city': city,
    };
    final response =
        await http.put(url, body: body, headers: await authHeader(user.token));

    return response.body == '"Address added successfully to ${user.email}"' &&
        response.statusCode == 200;
  }

  //SET DEFAULT ADDRESS
  setDefaultAddress() async {
    await checkAuth(context);
    setState(() {
      _isLoading = true;
    });

    if (await addAddress(is_current: true)) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Set As Default Address",
        Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading = false;
      });
    } else {
      mySnackBar(
        context,
        kErrorColor,
        "Failed!",
        "Failed to Set as Default Address",
        Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth(context);
    _addressTitleEC.text = widget.address.title ?? '';
    _streetAddressEC.text = widget.address.streetAddress ?? '';
    _apartmentDetailsEC.text = widget.address.details ?? '';
    _phoneNumberEC.text = widget.address.phone ?? '';
    _recipientNameEC.text = widget.address.recipientName ?? '';
    country = widget.address.country ?? '';
    state = widget.address.state ?? '';
    city = widget.address.city ?? '';
  }

  //SAVE NEW ADDRESS
  saveNewAddress() async {
    await checkAuth(context);
    setState(() {
      _isLoading2 = true;
    });

    if (await addAddress(is_current: false)) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Added Address",
        Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading2 = false;
      });
    } else {
      mySnackBar(
        context,
        kErrorColor,
        "Failed!",
        "Failed to Add Address",
        Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Edit Address ",
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
                            hintText:
                                "Enter address name tag e.g my work, my home....",
                            controller: _addressTitleEC,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            focusNode: _addressTitleFN,
                            validator: (value) {
                              RegExp locationNamePattern = RegExp(r'^.{3,}$');
                              if (value == null || value!.isEmpty) {
                                _addressTitleFN.requestFocus();
                                return "Enter a title";
                              } else if (!locationNamePattern.hasMatch(value)) {
                                _recipientNameFN.requestFocus();
                                return "Please enter a valid name";
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
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      Column(
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
                            controller: _recipientNameEC,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            focusNode: _recipientNameFN,
                            validator: (value) {
                              //username pattern
                              //Min. of 3 characters
                              RegExp userNamePattern = RegExp(r'^.{3,}$');
                              if (value == null || value!.isEmpty) {
                                _recipientNameFN.requestFocus();
                                return "Enter your name";
                              } else if (!userNamePattern.hasMatch(value)) {
                                _recipientNameFN.requestFocus();
                                return "Please enter a valid name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _recipientNameEC.text = value!;
                            },
                          ),
                        ],
                      ),
                      kSizedBox,
                      Column(
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
                      kSizedBox,
                      Column(
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
                      kSizedBox,
                      Column(
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
                            onCountryChanged: (country) {
                              countryDialCode = country.dialCode;
                            },
                            initialValue: widget.address.phone,
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
                      kSizedBox,
                      Column(
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
                            currentCity: city,
                            currentState: state,
                            currentCountry: country,
                            key: _cscPickerKey,
                            layout: Layout.vertical,
                            countryDropdownLabel: "Select country",
                            stateDropdownLabel: "Select state",
                            cityDropdownLabel: "Select city",
                            onCountryChanged: (data) {
                              setState(() {
                                country = data;
                              });
                            },
                            onStateChanged: (data) {
                              setState(() {
                                state = data;
                              });
                            },
                            onCityChanged: (data) {
                              setState(() {
                                city = data;
                              });
                            },
                          ),
                        ],
                      ),
                      kSizedBox,
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              _isLoading
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
              _isLoading2
                  ? Center(
                      child: SpinKitChasingDots(
                        color: kAccentColor,
                        duration: const Duration(seconds: 1),
                      ),
                    )
                  : MyElevatedButton(
                      title: "Save Changes",
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
