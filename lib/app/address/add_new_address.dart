// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:benji_user/src/common_widgets/textformfield/my_maps_textformfield.dart';
import 'package:benji_user/src/providers/keys.dart';
import 'package:benji_user/src/repo/models/googleMaps/autocomplete_prediction.dart';
import 'package:benji_user/src/repo/utils/base_url.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:benji_user/src/repo/utils/network_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/common_widgets/textformfield/my textformfield.dart';
import '../../src/common_widgets/textformfield/my_intl_phonefield.dart';
import '../../src/others/location_list_tile.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/googleMaps/places_autocomplete_response.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../theme/colors.dart';
import 'get_location_on_map.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  @override
  void dispose() {
    selectedLocation.dispose();

    super.dispose();
  }

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();
  // final _cscPickerKey = GlobalKey<CSCPickerState>();

  //===================== CONTROLLERS =======================\\
  final _scrollController = ScrollController();
  final TextEditingController _addressTitleEC = TextEditingController();

  final TextEditingController _phoneNumberEC = TextEditingController();
  final TextEditingController _mapsLocationEC = TextEditingController();

  //===================== FOCUS NODES =======================\\
  final FocusNode _addressTitleFN = FocusNode();
  final FocusNode _recipientNameFN = FocusNode();

  final FocusNode _phoneNumberFN = FocusNode();
  final FocusNode _mapsLocationFN = FocusNode();

  //===================== ALL VARIABLES =======================\\
  String? country;
  String? state;
  String? city;
  String countryDialCode = '234';
  List<AutocompletePrediction> placePredictions = [];
  final selectedLocation = ValueNotifier<String?>(null);

  //===================== BOOL VALUES =======================\\
  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _typing = false;
  //===================== FUNCTIONS =======================\\
  Future<bool> addAddress({bool is_current = true}) async {
    final url = Uri.parse('$baseURL/address/addAddress');
    List<String> countryList = country!.split(' ');
    final User? user = await getUser();

    final body = {
      'user_id': user!.id.toString(),
      'title': _addressTitleEC.text,
      // 'recipient_name': _recipientNameEC.text,
      'phone': "+$countryDialCode${_phoneNumberEC.text}",
      // 'street_address': _streetAddressEC.text,
      // 'details': _apartmentDetailsEC.text,
      'country': countryList[countryList.length - 1],
      'state': state,
      'city': city,
      'is_current': is_current.toString(),
    };
    final response =
        await http.post(url, body: body, headers: await authHeader());

    return response.body == '"Address added successfully to ${user.email}"' &&
        response.statusCode == 200;
  }

  //SET DEFAULT ADDRESS
  setDefaultAddress() async {
    setState(() {
      _isLoading = true;
    });

    await checkAuth(context);

    if (await addAddress(is_current: true)) {
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

  //SAVE NEW ADDRESS
  saveNewAddress() async {
    setState(() {
      _isLoading2 = true;
    });

    await checkAuth(context);

    if (await addAddress(is_current: false)) {
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

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        '/maps/api/place/autocomplete/json', //unencoder path
        {
          "input": query, //query params
          "key": googlePlacesApiKey, //google places api key
        });
    if (kDebugMode) {
      print(uri);
    }
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutoCompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }

      if (kDebugMode) {
        print(response);
      }
    }
  }

  //===================== Navigation =======================\\

  void _toGetLocationOnMap() => Get.to(
        () => const GetLocationOnMap(),
        routeName: 'GetLocationOnMap',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "New Address ",
          toolbarHeight: 80,
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                Form(
                  key: _formKey,
                  child: ValueListenableBuilder(
                      valueListenable: selectedLocation,
                      builder: (context, selectedLocationValue, index) {
                        return Column(
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
                                MyTextFormField(
                                  hintText:
                                      "Enter address name tag e.g my work, my home....",
                                  textCapitalization: TextCapitalization.words,
                                  controller: _addressTitleEC,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.name,
                                  focusNode: _addressTitleFN,
                                  validator: (value) {
                                    RegExp locationNamePattern =
                                        RegExp(r'^.{3,}$');
                                    if (value == null || value!.isEmpty) {
                                      _addressTitleFN.requestFocus();
                                      return "Enter a title";
                                    } else if (!locationNamePattern
                                        .hasMatch(value)) {
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
                                const Text(
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
                            kSizedBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Location',
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                kHalfSizedBox,
                                MyMapsTextFormField(
                                  controller: _mapsLocationEC,
                                  validator: (value) {
                                    if (value == null) {
                                      _mapsLocationFN.requestFocus();
                                      "Enter a location";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    placeAutoComplete(value);
                                    setState(() {
                                      selectedLocation.value = value;
                                      _typing = true;
                                    });
                                    if (kDebugMode) {
                                      print(
                                          "ONCHANGED VALUE: ${selectedLocation.value}");
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  focusNode: _mapsLocationFN,
                                  hintText: "Search a location",
                                  textInputType: TextInputType.text,
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
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
                                  onPressed: _toGetLocationOnMap,
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
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: kLightGreyColor,
                                ),
                                const Text(
                                  "Suggestions:",
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                kHalfSizedBox,
                                SizedBox(
                                  height: () {
                                    if (_typing == false) {
                                      return 0.0;
                                    }
                                    if (_typing == true) {
                                      return 150.0;
                                    }
                                  }(),
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      itemCount: placePredictions.length,
                                      itemBuilder: (context, index) =>
                                          LocationListTile(
                                        onTap: () {
                                          final newLocation =
                                              placePredictions[index]
                                                  .description!;
                                          selectedLocation.value = newLocation;
                                          // LatLng latlng = await LatLng();
                                          setState(() {
                                            _mapsLocationEC.text = newLocation;
                                          });
                                        },
                                        location: placePredictions[index]
                                            .description!,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                kSizedBox,
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
                            // setDefaultAddress();
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
                        title: "Save New Address",
                        onPressed: (() async {
                          if (_formKey.currentState!.validate()) {
                            // saveNewAddress();
                          }
                        }),
                      ),
                const SizedBox(height: kDefaultPadding * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
