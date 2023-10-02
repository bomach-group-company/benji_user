// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:benji_user/src/repo/models/address/address_model.dart';
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
  final TextEditingController _addressTitleEC = TextEditingController();
  final TextEditingController _apartmentDetailsEC = TextEditingController();
  final TextEditingController _phoneNumberEC = TextEditingController();

  //===================== FOCUS NODES =======================\\
  final FocusNode _addressTitleFN = FocusNode();
  final FocusNode _apartmentDetailsFN = FocusNode();
  final FocusNode _phoneNumberFN = FocusNode();

  //===================== ALL VARIABLES =======================\\
  String countryDialCode = '234';

  //===================== BOOL VALUES =======================\\
  bool _isLoading = false;
  bool _isLoading2 = false;

  //===================== FUNCTIONS =======================\\
  Future<bool> updateAddress({bool is_current = true}) async {
    final url = Uri.parse(
        '$baseFrontendUrl/address/changeAddressDetails/${widget.address.id}');

    final body = {
      'title': _addressTitleEC.text,
      'phone': "+$countryDialCode${_phoneNumberEC.text}",
      'details': _apartmentDetailsEC.text,
    };
    final response = await http.put(url,
        body: jsonEncode(body), headers: await authHeader());
    try {
      Address.fromJson(jsonDecode(response.body));
      if (is_current) {
        setCurrentAddress(widget.address.id!);
      }
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  //SET DEFAULT ADDRESS
  setDefaultAddress() async {
    setState(() {
      _isLoading = true;
    });

    await checkAuth(context);

    if (await updateAddress(is_current: true)) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Set As Default Address",
        const Duration(seconds: 2),
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
        const Duration(seconds: 2),
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
    // _streetAddressEC.text = widget.address.streetAddress ?? '';
    _apartmentDetailsEC.text = widget.address.details ?? '';
    _phoneNumberEC.text =
        (widget.address.phone ?? '').replaceFirst('+$countryDialCode', '');
  }

  //SAVE NEW ADDRESS
  updateUserAddress() async {
    setState(() {
      _isLoading2 = true;
    });
    await checkAuth(context);

    if (await updateAddress(is_current: false)) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Added Address",
        const Duration(seconds: 2),
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
        const Duration(seconds: 2),
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
          actions: const [],
        ),
        body: Container(
          margin: const EdgeInsets.only(
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
                        const Text(
                          'Title (My Home, My Office)',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        kHalfSizedBox,
                        const Text(
                          'Name tag of this address e.g my work, my apartment',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
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
                              _addressTitleFN.requestFocus();
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addressTitleEC.text = value!;
                          },
                        ),
                      ],
                    ),
                    kSizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
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
                        const Text(
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
                          initialCountryCode: countryDialCode,
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
                    kSizedBox,
                  ],
                ),
              ),
              const SizedBox(
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
                          updateUserAddress();
                        }
                      }),
                    ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
