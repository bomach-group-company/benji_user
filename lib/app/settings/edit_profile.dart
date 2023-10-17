// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/utils/base_url.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/components/textformfield/my_intl_phonefield.dart';
import '../../src/components/textformfield/name_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
//======================================== Initial State and dispose ==============================================\\
  @override
  void initState() {
    super.initState();
    getData();
  }

//======================================== ALL VARIABLES ==============================================\\
  final String countryDialCode = '234';
//======================================== GLOBAL KEYS ==============================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== CONTROLLERS ====================================\\
  final _scrollController = ScrollController();

  final TextEditingController _userFirstNameEC = TextEditingController();
  final TextEditingController _userLastNameEC = TextEditingController();
  TextEditingController phoneNumberEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\
  FocusNode userFirstNameFN = FocusNode();
  FocusNode userLastNameFN = FocusNode();
  FocusNode phoneNumberFN = FocusNode();

  //=========================== BOOL VALUES ====================================\\
  bool _isLoading = false;

  //=========================== FUNCTIONS ====================================\\
  getData() async {
    checkAuth(context);
    User? user = await getUser();

    _userFirstNameEC.text = user!.firstName!;
    _userLastNameEC.text = user.lastName!;
    phoneNumberEC.text =
        (user.phone ?? '').replaceFirst('+$countryDialCode', '');
  }

  Future<bool> updateProfile({bool is_current = true}) async {
    User? user = await getUser();

    // User data update
    final url = Uri.parse('$baseURL/clients/changeClient/${user!.id}');
    final url_get_user = Uri.parse('$baseURL/clients/getClient/${user.id}');

    final body = {
      'first_name': _userFirstNameEC.text,
      'last_name': _userLastNameEC.text,
      'phone': "+$countryDialCode${phoneNumberEC.text}",
    };
    final response = await http.post(
      url,
      body: body,
      headers: await authHeader(),
    );
    final get_response = await http.get(
      url_get_user,
      headers: await authHeader(),
    );

    try {
      if (response.statusCode == 200 && get_response.statusCode == 200) {
        await saveUser(get_response.body, user.token!);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> updateData() async {
    setState(() {
      _isLoading = true;
    });

    bool res = await updateProfile();

    if (res) {
      //Display snackBar
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Your changes have been saved successfully".toUpperCase(),
        const Duration(seconds: 2),
      );

      Get.back();
    } else {
      mySnackBar(
        context,
        kAccentColor,
        "Failed!",
        "Something unexpected happened, please try again later".toUpperCase(),
        const Duration(seconds: 2),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Edit Profile",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        bottomNavigationBar: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: MyElevatedButton(
                  onPressed: (() async {
                    if (_formKey.currentState!.validate()) {
                      updateData();
                    }
                  }),
                  title: "Save",
                ),
              ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Name".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      NameTextFormField(
                        controller: _userFirstNameEC,
                        validator: (value) {
                          RegExp userNamePattern = RegExp(
                            r'^.{3,}$', //Min. of 3 characters
                          );
                          if (value == null || value!.isEmpty) {
                            userFirstNameFN.requestFocus();
                            return "Enter your first name";
                          } else if (!userNamePattern.hasMatch(value)) {
                            userFirstNameFN.requestFocus();
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userFirstNameEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: userFirstNameFN,
                        hintText: "Enter first name",
                      ),
                      kSizedBox,
                      Text(
                        "Last Name".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      NameTextFormField(
                        controller: _userLastNameEC,
                        hintText: "Enter last name",
                        validator: (value) {
                          RegExp userNamePattern = RegExp(
                            r'^.{3,}$', //Min. of 3 characters
                          );
                          if (value == null || value!.isEmpty) {
                            userLastNameFN.requestFocus();
                            return "Enter your last name";
                          } else if (!userNamePattern.hasMatch(value)) {
                            userLastNameFN.requestFocus();
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userLastNameEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: userLastNameFN,
                      ),
                      kSizedBox,
                      Text(
                        "Phone Number".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                      kSizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
