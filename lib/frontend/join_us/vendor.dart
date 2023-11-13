// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously, unused_element

import 'package:benji/app/address/get_location_on_map.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/components/textformfield/my%20textformfield.dart';
import 'package:benji/src/components/textformfield/my_maps_textformfield.dart';
import 'package:benji/src/frontend/utils/constant.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/repo/controller/lat_lng_controllers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorTab extends StatefulWidget {
  const VendorTab({super.key});

  @override
  State<VendorTab> createState() => _VendorTabState();
}

class _VendorTabState extends State<VendorTab> {
  // variales
  String? latitude;

  String? longitude;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  // controller
  final TextEditingController _nameEC = TextEditingController();
  final TextEditingController _userEmailEC = TextEditingController();
  final TextEditingController _phonenumberEC = TextEditingController();
  final TextEditingController _businessNameEC = TextEditingController();
  final TextEditingController _countryEC = TextEditingController();
  final TextEditingController _stateEC = TextEditingController();
  final TextEditingController _lgaEC = TextEditingController();

  // final TextEditingController _businessRegNoEC = TextEditingController();

  final TextEditingController _locationEC = TextEditingController();

  // final TextEditingController _nameEC = TextEditingController();
  final LatLngDetailController latLngDetailController =
      Get.put(LatLngDetailController());

  // Focus node
  final FocusNode _nameFN = FocusNode();
  final FocusNode _userEmailFN = FocusNode();
  final FocusNode _phonenumberFN = FocusNode();
  final FocusNode _businessNameFN = FocusNode();
  final FocusNode _countryFN = FocusNode();
  final FocusNode _stateFN = FocusNode();
  final FocusNode _lgaFN = FocusNode();

  // final FocusNode _businessRegNoFN = FocusNode();

  final FocusNode _locationFN = FocusNode();

  _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final url =
          Uri.parse('$baseFrontendUrl/joinus/createBusinessOwnerRequest');

      final body = {
        'fullname': _nameEC.text,
        'email': _userEmailEC.text,
        'phone': _phonenumberEC.text,
        'address': _locationEC.text,
        'business_name': _businessNameEC.text,
        'business_type': 'N/A',
        'country': _countryEC.text,
        'state': _stateEC.text,
        'lga': _lgaEC.text,
        'latitude': longitude,
        'longitude': longitude,
      };
      if (kDebugMode) {
        print("This is the body: $body");
      }
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        mySnackBar(
          context,
          kSuccessColor,
          "Success!",
          "Request summited",
          const Duration(seconds: 2),
        );
        _formKey.currentState!.reset();
      } else {
        mySnackBar(
          context,
          kAccentColor,
          "Failed!",
          "Request Failed",
          const Duration(seconds: 2),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

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
    latitude = latLngDetailController.latLngDetail.value[0];
    longitude = latLngDetailController.latLngDetail.value[1];
    _locationEC.text = latLngDetailController.latLngDetail.value[2];
    latLngDetailController.setEmpty();
    if (kDebugMode) {
      print("LATLNG: $latitude,$longitude");
      print(_locationEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
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
                return "Enter a full name";
              } else if (!pattern.hasMatch(value)) {
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
                return "Enter your email address";
              } else if (!emailPattern.hasMatch(value)) {
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
              RegExp pattern = RegExp(
                  r'^(?:\+?\d{1,3}[\s.-]?)?\(?\d{1,4}\)?[\s.-]?\d{1,4}[\s.-]?\d{1,9}$');
              if (value == null || value!.isEmpty) {
                return "Enter a phone number";
              } else if (!pattern.hasMatch(value)) {
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
            'Business Name',
            style: TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          kHalfSizedBox,
          MyTextFormField(
            hintText: "Enter business name",
            textCapitalization: TextCapitalization.words,
            controller: _businessNameEC,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            focusNode: _businessNameFN,
            validator: (value) {
              RegExp pattern = RegExp(r'^.{1,}$');
              if (value == null || value!.isEmpty) {
                return "Enter a business name";
              } else if (!pattern.hasMatch(value)) {
                return "Please enter a valid business name";
              }
              return null;
            },
            onSaved: (value) {
              _businessNameEC.text = value!;
            },
          ),
          kSizedBox,
          const Text(
            'Country',
            style: TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          kHalfSizedBox,
          MyTextFormField(
            hintText: "Enter country your business is located",
            textCapitalization: TextCapitalization.words,
            controller: _countryEC,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            focusNode: _countryFN,
            validator: (value) {
              RegExp pattern = RegExp(r'^.{1,}$');
              if (value == null || value!.isEmpty) {
                return "Enter a Country";
              } else if (!pattern.hasMatch(value)) {
                return "Please enter a valid Country";
              }
              return null;
            },
            onSaved: (value) {
              _countryEC.text = value!;
            },
          ),
          kSizedBox,
          const Text(
            'State',
            style: TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          kHalfSizedBox,
          MyTextFormField(
            hintText: "Enter state your business is located",
            textCapitalization: TextCapitalization.words,
            controller: _stateEC,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            focusNode: _stateFN,
            validator: (value) {
              RegExp pattern = RegExp(r'^.{1,}$');
              if (value == null || value!.isEmpty) {
                return "Enter state";
              } else if (!pattern.hasMatch(value)) {
                return "Please enter a valid state";
              }
              return null;
            },
            onSaved: (value) {
              _stateEC.text = value!;
            },
          ),
          kSizedBox,
          const Text(
            'Local Government Area',
            style: TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          kHalfSizedBox,
          MyTextFormField(
            hintText: "Enter Local Government Area",
            textCapitalization: TextCapitalization.words,
            controller: _lgaEC,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            focusNode: _lgaFN,
            validator: (value) {
              RegExp pattern = RegExp(r'^.{1,}$');
              if (value == null || value!.isEmpty) {
                return "Enter a Local Government Area";
              } else if (!pattern.hasMatch(value)) {
                return "Please enter a valid Local Government Area";
              }
              return null;
            },
            onSaved: (value) {
              _lgaEC.text = value!;
            },
          ),
          kSizedBox,
          const Text(
            'Business Address',
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
              // RegExp pattern = RegExp(r'^\d+\s+[a-zA-Z0-9\s.-]+$');
              if (value!.isEmpty || value == null) {
                return "Enter business address";
              }
              return null;
            },
            onSaved: (value) {
              _locationEC.text = value;
            },
            textInputAction: TextInputAction.done,
            focusNode: _locationFN,
            hintText: "location",
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
          // InkWell(
          //   borderRadius: BorderRadius.circular(16),
          //   splashColor: Colors.blue.shade50,
          //   focusColor: Colors.blue.shade50,
          //   highlightColor: Colors.blue.shade50,
          //   onTap: () async {
          //     FilePickerResult? result = await FilePicker.platform.pickFiles(
          //       allowMultiple: true,
          //       allowedExtensions: ['pdf', 'doc', 'docx'],
          //     );

          //     if (result != null) {
          //       // ignore: unused_local_variable
          //       List<File> files =
          //           result.files.map((file) => File(file.path!)).toList();
          //     } else {
          //       // User canceled the picker
          //     }
          //     // Handle the selected file, e.g., save or upload it.
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 144,
          //     decoration: ShapeDecoration(
          //       shape: RoundedRectangleBorder(
          //         side: const BorderSide(
          //           width: 1,
          //           style: BorderStyle.solid,
          //           strokeAlign: BorderSide.strokeAlignOutside,
          //           color: Color(0xFFE6E6E6),
          //         ),
          //         borderRadius: BorderRadius.circular(16),
          //       ),
          //     ),
          //     child: Align(
          //       alignment: Alignment.center,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const FaIcon(FontAwesomeIcons.cloudArrowUp),
          //           // Image.asset(
          //           //   "assets/icons/image-upload.png",
          //           // ),
          //           kHalfSizedBox,
          //           Text(
          //             'Upload a document (Optional)',
          //             style: TextStyle(
          //               color: kTextGreyColor,
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // kSizedBox,
          kHalfSizedBox,
          MyElevatedButton(
            isLoading: isLoading,
            title: "Submit",
            onPressed: _submit,
          ),
          kSizedBox,
        ],
      ),
    );
  }
}
