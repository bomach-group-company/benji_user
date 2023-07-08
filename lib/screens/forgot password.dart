import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../reusable widgets/email textformfield.dart';
import '../reusable widgets/my appbar.dart';
import '../reusable widgets/my floating snackbar.dart';
import '../reusable widgets/reusable authentication first half.dart';
import '../theme/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController emailController = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  FocusNode emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: MyAppBar(
          title: "",
          elevation: 0.0,
          toolbarHeight: 80,
          actions: [],
          backgroundColor: kTransparentColor,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ReusableAuthenticationFirstHalf(
                title: "Forgot Password",
                subtitle:
                    "Forgot your password? Don't panic, enter your email below and we will send you a code via which you need to recover your password",
                decoration: BoxDecoration(),
                imageContainerHeight: 0,
              ),
              kSizedBox,
              Expanded(
                child: Container(
                  width: media.size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  child: Text(
                                    'Email',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(
                                        0xFF31343D,
                                      ),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                EmailTextFormField(
                                  controller: emailController,
                                  emailFocusNode: emailFocusNode,
                                  textInputAction: TextInputAction.go,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      mySnackBar(
                                        context,
                                        "An OTP code has been sent to your email",
                                        kAccentColor,
                                        SnackBarBehavior.floating,
                                        kDefaultPadding,
                                      );
                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const LoginSplashScreen(),
                                      //   ),
                                      // );
                                    }
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: kAccentColor,
                                    fixedSize: Size(media.size.width, 50),
                                  ),
                                  child: Text(
                                    'Send Code'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.46,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
