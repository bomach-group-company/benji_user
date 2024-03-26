// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/components/section/reusable_authentication_first_half.dart';
import '../../src/components/snackbar/my_fixed_snackbar.dart';
import '../../src/components/textformfield/password_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/controller/error_controller.dart';
import '../../theme/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== CONTROLLERS ====================================\\

  final TextEditingController _userPasswordEC = TextEditingController();
  TextEditingController confirmPasswordEC = TextEditingController();
  final TextEditingController _userOldPasswordEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\
  final FocusNode _userPasswordFN = FocusNode();
  FocusNode confirmPasswordFN = FocusNode();
  final FocusNode _userOldPasswordFN = FocusNode();

  //=========================== BOOL VALUES====================================\\
  bool _isLoading = false;
  bool _validAuthCredentials = false;
  bool isPWSuccess = false;
  var _isObscured;

  //=========================== FUNCTIONS ====================================\\
  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse('$baseURL/auth/changeNewPassword/');
    try {
      Map body = {
        'new_password': _userPasswordEC.text,
        'confirm_password': confirmPasswordEC.text,
        'old_password': _userOldPasswordEC.text,
      };
      if (kDebugMode) {
        print(body);
      }
      final response = await http.post(
        url,
        body: body,
        headers: await authHeader(),
      );
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        setState(() {
          _validAuthCredentials = true;
        });

        //Display snackBar
        ApiProcessorController.successSnack("Password changed successfully.");

        Get.close(1);
      } else {
        ApiProcessorController.errorSnack(
            jsonDecode(response.body)['message'] ??
                "Your old password does not match");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e \nPlease contact support or try again later.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  //=========================== STATES ====================================\\

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        resizeToAvoidBottomInset: true,
        appBar: const MyAppBar(
          title: "",
          elevation: 0.0,
          actions: [],
          backgroundColor: kTransparentColor,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: LayoutGrid(
            columnSizes: breakPointDynamic(
              media.size.width,
              [1.fr],
              [1.fr],
              [1.fr, 1.fr],
              [1.fr, 1.fr],
            ),
            rowSizes: breakPointDynamic(
              media.size.width,
              [auto, 1.fr],
              [auto, 1.fr],
              [1.fr],
              [1.fr],
            ),
            children: [
              Column(
                children: [
                  Expanded(
                    child: () {
                      if (_validAuthCredentials) {
                        return ReusableAuthenticationFirstHalf(
                          title: "Change password",
                          subtitle:
                              "Just enter a new password here and you are good to go!",
                          curves: Curves.easeInOut,
                          duration: const Duration(),
                          containerChild: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: kSuccessColor,
                              size: 80,
                            ),
                          ),
                          decoration: ShapeDecoration(
                              color: kPrimaryColor, shape: const OvalBorder()),
                          imageContainerHeight:
                              deviceType(media.size.width) > 2 ? 200 : 100,
                        );
                      } else {
                        return ReusableAuthenticationFirstHalf(
                          title: "Change password",
                          subtitle:
                              "Just enter a new password here and you are good to go!",
                          curves: Curves.easeInOut,
                          duration: const Duration(),
                          containerChild: Center(
                            child: FaIcon(
                              FontAwesomeIcons.key,
                              color: kSecondaryColor,
                              size: 60,
                            ),
                          ),
                          decoration: ShapeDecoration(
                              color: kPrimaryColor, shape: const OvalBorder()),
                          imageContainerHeight:
                              deviceType(media.size.width) > 2 ? 200 : 100,
                        );
                      }
                    }(),
                  ),
                ],
              ),
              Container(
                height: media.size.height,
                width: media.size.width,
                padding: const EdgeInsets.only(
                  top: kDefaultPadding * 0.5,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        breakPoint(media.size.width, 24, 24, 0, 0)),
                    topRight: Radius.circular(
                        breakPoint(media.size.width, 24, 24, 0, 0)),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            child: Text(
                              'Enter Old Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          PasswordTextFormField(
                            controller: _userOldPasswordEC,
                            passwordFocusNode: _userOldPasswordFN,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value == "") {
                                _userOldPasswordFN.requestFocus();
                                return "Enter your current password";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userOldPasswordEC.text = value;
                            },
                            suffixIcon: const IconButton(
                              onPressed: null,
                              icon: Icon(null),
                            ),
                          ),
                          kHalfSizedBox,
                          //new password
                          const SizedBox(
                            child: Text(
                              'Enter New Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          PasswordTextFormField(
                            controller: _userPasswordEC,
                            passwordFocusNode: _userPasswordFN,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              RegExp passwordPattern = RegExp(
                                r'^.{8,}$',
                              );
                              if (value == null || value == "") {
                                _userPasswordFN.requestFocus();
                                return "Enter your password";
                              } else if (!passwordPattern.hasMatch(value)) {
                                _userPasswordFN.requestFocus();
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userPasswordEC.text = value;
                            },
                            suffixIcon: const IconButton(
                              onPressed: null,
                              icon: Icon(null),
                            ),
                          ),
                          kSizedBox,
                          kHalfSizedBox,
                          FlutterPwValidator(
                            uppercaseCharCount: 1,
                            lowercaseCharCount: 1,
                            numericCharCount: 1,
                            controller: _userPasswordEC,
                            width: 400,
                            height: 150,
                            minLength: 8,
                            onSuccess: () {
                              setState(() {
                                isPWSuccess = true;
                              });
                              myFixedSnackBar(
                                context,
                                "Password matches requirement",
                                kSuccessColor,
                                const Duration(
                                  seconds: 1,
                                ),
                              );
                            },
                            onFail: () {
                              setState(() {
                                isPWSuccess = false;
                              });
                            },
                          ),
                          kSizedBox,
                          const SizedBox(
                            child: Text(
                              'Confirm Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          PasswordTextFormField(
                            controller: confirmPasswordEC,
                            passwordFocusNode: confirmPasswordFN,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              RegExp passwordPattern = RegExp(
                                r'^.{8,}$',
                              );
                              if (value == null || value == "") {
                                confirmPasswordFN.requestFocus();
                                return "Confirm your password";
                              }
                              if (value != _userPasswordEC.text) {
                                return "Password does not match";
                              } else if (!passwordPattern.hasMatch(value)) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              confirmPasswordEC.text = value;
                            },
                            suffixIcon: const IconButton(
                              onPressed: null,
                              icon: Icon(null),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    // _isLoading
                    //     ? Center(
                    //         child: CircularProgressIndicator(
                    //           color: kAccentColor,
                    //         ),
                    //       )
                    //     :
                    MyElevatedButton(
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          loadData();
                        }
                      }),
                      title: "Save",
                      isLoading: _isLoading,
                      // style: ElevatedButton.styleFrom(
                      //   elevation: 10,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   backgroundColor: kAccentColor,
                      //   fixedSize: Size(media.size.width, 50),
                      // ),
                      // child: Text(
                      //   'Save'.toUpperCase(),
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                    ),
                    kSizedBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
