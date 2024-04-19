// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:benji/app/terms/terms_and_conditions.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/repo/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/components/section/reusable_authentication_first_half.dart';
import '../../src/components/textformfield/email_textformfield.dart';
import '../../src/components/textformfield/my_phone_field.dart';
import '../../src/components/textformfield/name_textformfield.dart';
import '../../src/components/textformfield/password_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
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

  final _userFirstNameEC = TextEditingController();
  final _userLastNameEC = TextEditingController();
  final _userEmailEC = TextEditingController();
  final _userPhoneNumberEC = TextEditingController();
  final _userPasswordEC = TextEditingController();
  final _referralCodeEC = TextEditingController();

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
  final userFirstNameFN = FocusNode();
  final userLastNameFN = FocusNode();
  final _userPhoneNumberFN = FocusNode();
  final _userEmailFN = FocusNode();
  final _userPasswordFN = FocusNode();
  final _referralCodeFN = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
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
                              if (value == null || value == "") {
                                // userFirstNameFN.requestFocus();
                                return "Enter your first name";
                              } else if (!userNamePattern.hasMatch(value)) {
                                // userFirstNameFN.requestFocus();
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
                              if (value == null || value == "") {
                                // userLastNameFN.requestFocus();
                                return "Enter your last name";
                              } else if (!userNamePattern.hasMatch(value)) {
                                // userLastNameFN.requestFocus();
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
                              if (value == null || value == "") {
                                // _userEmailFN.requestFocus();
                                return "Enter your email address";
                              } else if (!emailPattern.hasMatch(value)) {
                                // _userEmailFN.requestFocus();
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
                          MyPhoneField(
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
                              if (value == null || value == "") {
                                return "Enter your phone number";
                              }
                              return null;
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
                              if (value == null || value == "") {
                                // _userPasswordFN.requestFocus();
                                return "Enter your password";
                              } else if (!passwordPattern.hasMatch(value)) {
                                // _userPasswordFN.requestFocus();
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
                    GetBuilder<SignupController>(
                      builder: (controller) {
                        return MyElevatedButton(
                          title: "SIGN UP",
                          disable: !isChecked,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await controller.signup(
                                  _userEmailEC.text,
                                  _userPasswordEC.text,
                                  _userPhoneNumberEC.text,
                                  _userFirstNameEC.text,
                                  _userLastNameEC.text,
                                  _referralCodeEC.text);
                            }
                          },
                          isLoading: controller.isLoad.value,
                        );
                      },
                    ),
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
