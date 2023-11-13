// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/section/reusable_authentication_first_half.dart';
import 'package:benji/src/components/textformfield/email_textformfield.dart';
import 'package:benji/src/components/textformfield/password_textformfield.dart';
import 'package:benji/src/repo/controller/login_controller.dart';
import 'package:benji/src/repo/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //=========================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== BOOL VALUES ====================================\\

  bool isLoading = false;

  var _isObscured;

  //=========================== STYLE ====================================\\

  TextStyle myAccentFontStyle = TextStyle(
    color: kAccentColor,
  );

  //=========================== FOCUS NODES ====================================\\
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  //=========================== FUNCTIONS ====================================\\

  //Navigate to forgotPassword
  void toForgotPasswordPage() => Get.to(
        () => const ForgotPassword(),
        duration: const Duration(milliseconds: 500),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Forgot Password",
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
                children: [
                  Expanded(
                    child: ReusableAuthenticationFirstHalf(
                      title: "Log In",
                      subtitle: "Please log in to your existing account",
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
                    ),
                  ),
                ],
              ),
              Container(
                width: media.width,
                height: media.height,
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
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
                              'Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          EmailTextFormField(
                            controller: emailController,
                            emailFocusNode: emailFocusNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              RegExp emailPattern = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                              );
                              if (value == null || value!.isEmpty) {
                                emailFocusNode.requestFocus();
                                return "Enter your email address";
                              } else if (!emailPattern.hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value;
                            },
                          ),
                          kSizedBox,
                          const SizedBox(
                            child: Text(
                              'Password',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          PasswordTextFormField(
                            controller: passwordController,
                            passwordFocusNode: passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              RegExp passwordPattern = RegExp(
                                r'^.{8,}$',
                              );
                              if (value == null || value!.isEmpty) {
                                passwordFocusNode.requestFocus();
                                return "Enter your password";
                              } else if (!passwordPattern.hasMatch(value)) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value;
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                              icon: _isObscured
                                  ? const Icon(
                                      Icons.visibility_off_rounded,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: kSecondaryColor,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: toForgotPasswordPage,
                          child: Text(
                            "Forgot Password",
                            style: myAccentFontStyle,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    GetBuilder<LoginController>(builder: (controller) {
                      return MyElevatedButton(
                        title: "LOG IN",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SendLogin data = SendLogin(
                                password: passwordController.text,
                                username: emailController.text);

                            await controller.login(data);
                          }
                        },
                        isLoading: controller.isLoad.value,
                      );
                    }),
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
