// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:benji/app/terms/terms_and_conditions.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/textformfield/my_intl_phonefield.dart';
import 'package:benji/src/repo/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/components/section/reusable_authentication_first_half.dart';
import '../../src/components/snackbar/my_fixed_snackbar.dart';
import '../../src/components/textformfield/email_textformfield.dart';
import '../../src/components/textformfield/name_textformfield.dart';
import '../../src/components/textformfield/password_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/services/api_url.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
import '../splash_screens/signup_splash_screen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  final bool logout;
  const SignUp({super.key, this.logout = false});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //=========================== INITIAL STATE AND DISPOSE ====================================\\
  @override
  void initState() {
    super.initState();
    if (widget.logout) {
      deleteUser();
    }
    isObscured = true;
  }

  //=========================== ALL VARIABBLES ====================================\\
  String countryDialCode = '234';
  //=========================== CONTROLLER ====================================\\

  final TextEditingController _userFirstNameEC = TextEditingController();
  final TextEditingController _userLastNameEC = TextEditingController();
  final TextEditingController _userEmailEC = TextEditingController();
  final TextEditingController _userPhoneNumberEC = TextEditingController();
  final TextEditingController _userPasswordEC = TextEditingController();
  final TextEditingController _referralCodeEC = TextEditingController();

  //=========================== KEYS ====================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== BOOL VALUES ====================================\\
  bool isLoading = false;
  bool validAuthCredentials = false;
  bool invalidAuthCredentials = false;
  bool isChecked = false;
  bool isPWSuccess = false;
  var isObscured;

  //=========================== FOCUS NODES ====================================\\
  FocusNode userFirstNameFN = FocusNode();
  FocusNode userLastNameFN = FocusNode();
  final FocusNode _userPhoneNumberFN = FocusNode();
  final FocusNode _userEmailFN = FocusNode();
  final FocusNode _userPasswordFN = FocusNode();
  final FocusNode _referralCodeFN = FocusNode();

  //=========================== FUNCTIONS ====================================\\
  void _checkBoxFunction(newVal) {
    setState(() {
      isChecked = newVal!;
    });
  }

  void _toTermsAndCondition() {
    Get.to(
      () => const TermsAndCondition(),
      routeName: 'TermsAndCondition',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void _toLoginPage() => Get.offAll(
        () => const Login(),
        routeName: 'Login',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        predicate: (routes) => false,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  Future<bool> createUser() async {
    final url = Uri.parse('$baseURL/clients/createClient');
    final body = {
      'email': _userEmailEC.text,
      'password': _userPasswordEC.text,
      'phone': "+$countryDialCode${_userPhoneNumberEC.text}",
      'username': _userEmailEC.text.split('@')[0],
      'first_name': _userFirstNameEC.text,
      'last_name': _userLastNameEC.text
    };

    if (_referralCodeEC.text.isNotEmpty) {
      body['agentReferralCode'] = _referralCodeEC.text;
    }

    final response = await http.post(url, body: body);
    return response.body == '"Client Created."' && response.statusCode == 200;
  }

  //=========================== REQUEST ====================================\\

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    await sendPostRequest(_userEmailEC.text, _userPasswordEC.text);

    setState(() {
      isLoading = false;
    });
  }

  //=========================== REQUEST ====================================\\
  Future<bool> saveUserAndToken(String token) async {
    try {
      final someUserData = await http.get(Uri.parse('$baseURL/auth/'),
          headers: await authHeader(token));
      int userId = jsonDecode(someUserData.body)['id'];

      final userData = await http.get(
          Uri.parse('$baseURL/clients/getClient/$userId'),
          headers: await authHeader(token));

      await saveUser(userData.body, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendPostRequest(String username, String password) async {
    bool isUserCreated = await createUser();

    final url = Uri.parse('$baseURL/auth/token');
    final body = {'username': username, 'password': password};

    final response = await http.post(url, body: body);
    dynamic token = jsonDecode(response.body)['token'];

    bool isUserSaved = await saveUserAndToken(token.toString());

    if (response.statusCode == 200 &&
        token.toString() != false.toString() &&
        isUserSaved &&
        isUserCreated) {
      setState(() {
        validAuthCredentials = true;
      });

      //Display snackBar
      myFixedSnackBar(
        context,
        "Signup Successful".toUpperCase(),
        kSuccessColor,
        const Duration(seconds: 2),
      );

      // Navigate to the new page
      Get.offAll(
        () => const SignUpSplashScreen(),
        routeName: 'SignUpSplashScreen',
        predicate: (route) => false,
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.fadeIn,
      );
    } else {
      setState(() {
        invalidAuthCredentials = true;
      });

      myFixedSnackBar(
        context,
        "Signup invalid".toUpperCase(),
        kAccentColor,
        const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: LayoutGrid(
            columnSizes: breakPointDynamic(
              media.width,
              [1.fr],
              [1.fr],
              [1.fr, 1.fr],
              [1.fr, 1.fr],
            ),
            rowSizes: breakPointDynamic(
              media.width,
              [auto, 1.fr],
              [auto, 1.fr],
              [1.fr],
              [1.fr],
            ),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: () {
                      if (validAuthCredentials) {
                        return ReusableAuthenticationFirstHalf(
                          title: "Sign up",
                          subtitle: "Please sign up to get started",
                          curves: Curves.easeInOut,
                          duration: const Duration(milliseconds: 300),
                          containerChild: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.unlockKeyhole,
                              color: kSuccessColor,
                              size: 80,
                              semanticLabel: "login__success_icon",
                            ),
                          ),
                          decoration: ShapeDecoration(
                            color: kPrimaryColor,
                            shape: const OvalBorder(),
                          ),
                          imageContainerHeight:
                              deviceType(media.width) > 2 ? 200 : 120,
                        );
                      } else {
                        if (invalidAuthCredentials) {
                          return ReusableAuthenticationFirstHalf(
                            title: "Sign up",
                            subtitle: "Please sign up to get started",
                            curves: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            containerChild: Center(
                              child: FaIcon(
                                FontAwesomeIcons.lock,
                                color: kAccentColor,
                                size: 80,
                                semanticLabel: "invalid_icon",
                              ),
                            ),
                            decoration: ShapeDecoration(
                              color: kPrimaryColor,
                              shape: const OvalBorder(),
                            ),
                            imageContainerHeight:
                                deviceType(media.width) > 2 ? 200 : 120,
                          );
                        } else {
                          return ReusableAuthenticationFirstHalf(
                            title: "Sign up",
                            subtitle: "Please sign up to get started",
                            curves: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            containerChild: Center(
                              child: FaIcon(
                                FontAwesomeIcons.lock,
                                color: kSecondaryColor,
                                size: 80,
                                semanticLabel: "lock_icon",
                              ),
                            ),
                            decoration: ShapeDecoration(
                              color: kPrimaryColor,
                              shape: const OvalBorder(),
                            ),
                            imageContainerHeight:
                                deviceType(media.width) > 2 ? 200 : 120,
                          );
                        }
                      }
                    }(),
                  ),
                ],
              ),
              Container(
                height: media.height,
                width: media.width,
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(breakPoint(media.width, 24, 24, 0, 0)),
                    topRight:
                        Radius.circular(breakPoint(media.width, 24, 24, 0, 0)),
                  ),
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
                          const SizedBox(
                            child: Text(
                              'First Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
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
                          const SizedBox(
                            child: Text(
                              'Last Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          NameTextFormField(
                            controller: _userLastNameEC,
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
                            hintText: "Enter last name",
                          ),
                          kSizedBox,
                          const SizedBox(
                            child: Text(
                              'Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          EmailTextFormField(
                            controller: _userEmailEC,
                            emailFocusNode: _userEmailFN,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              RegExp emailPattern = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                              );
                              if (value == null || value!.isEmpty) {
                                _userEmailFN.requestFocus();
                                return "Enter your email address";
                              } else if (!emailPattern.hasMatch(value)) {
                                _userEmailFN.requestFocus();
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userEmailEC.text = value;
                            },
                          ),
                          kSizedBox,
                          const SizedBox(
                            child: Text(
                              'Phone Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          MyIntlPhoneField(
                            controller: _userPhoneNumberEC,
                            initialCountryCode: "NG",
                            invalidNumberMessage: "Invalid Phone Number",
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: true,
                            showDropdownIcon: true,
                            onCountryChanged: (country) {
                              countryDialCode = country.dialCode;
                            },
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: kAccentColor,
                            ),
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Enter your phone number";
                              }
                            },
                            onSaved: (value) {
                              _userPhoneNumberEC.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            focusNode: _userPhoneNumberFN,
                          ),
                          kSizedBox,
                          const Text(
                              'Referral code (Optional)',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                          NameTextFormField(
                            controller: _referralCodeEC,
                            validator: (value) {
                              
                              return null;
                            },
                            onSaved: (value) {
                              _referralCodeEC.text = value;
                            },
                            textInputAction: TextInputAction.next,
                            nameFocusNode: _referralCodeFN,
                            hintText: "Referral code",
                          ),
                          kSizedBox,
                          const SizedBox(
                            child: Text(
                              'Password',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          PasswordTextFormField(
                            controller: _userPasswordEC,
                            passwordFocusNode: _userPasswordFN,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscured,
                            textInputAction: TextInputAction.go,
                            validator: (value) {
                              RegExp passwordPattern = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                              if (value == null || value!.isEmpty) {
                                _userPasswordFN.requestFocus();
                                return "Enter your password";
                              } else if (!passwordPattern.hasMatch(value)) {
                                _userPasswordFN.requestFocus();
                                return "Password needs to match format below.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userPasswordEC.text = value;
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              icon: isObscured
                                  ? const Icon(
                                      Icons.visibility,
                                    )
                                  : Icon(
                                      Icons.visibility_off_rounded,
                                      color: kSecondaryColor,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        // myFixedSnackBar(
                        //   context,
                        //   "Password matches requirement",
                        //   kSuccessColor,
                        //   const Duration(
                        //     seconds: 1,
                        //   ),
                        // );
                      },
                      onFail: () {
                        setState(() {
                          isPWSuccess = false;
                        });
                      },
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isChecked,
                          splashRadius: 0,
                          activeColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          onChanged: _checkBoxFunction,
                        ),
                        Row(
                          children: [
                            const Text('Accept our'),
                            InkWell(
                              onTap: _toTermsAndCondition,
                              borderRadius: BorderRadius.circular(12),
                              mouseCursor: SystemMouseCursors.click,
                              child: Text(
                                ' Terms and Conditions.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kSizedBox,
                    GetBuilder<SignupController>(builder: (controller) {
                      return MyElevatedButton(
                        title: "SIGN UP",
                        onPressed: !isChecked
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.signup(
                                      _userEmailEC.text,
                                      _userPasswordEC.text,
                                      _userPhoneNumberEC.text,
                                      _userFirstNameEC.text,
                                      _userLastNameEC.text);
                                }
                              },
                        isLoading: controller.isLoad.value,
                      );
                    }),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF646982),
                          ),
                        ),
                        TextButton(
                          onPressed: _toLoginPage,
                          child: Text(
                            "Log in",
                            style: TextStyle(color: kAccentColor),
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
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
