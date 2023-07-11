// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../reusable widgets/email textformfield.dart';
import '../reusable widgets/my appbar.dart';
import '../reusable widgets/my floating snackbar.dart';
import '../reusable widgets/name textformfield.dart';
import '../reusable widgets/password textformfield.dart';
import '../reusable widgets/reusable authentication first half.dart';
import '../splash screens/signup splash screen.dart';
import '../theme/colors.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController userFirstNameEC = TextEditingController();
  TextEditingController userLastNameEC = TextEditingController();
  TextEditingController userEmailEC = TextEditingController();
  TextEditingController userPasswordEC = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== BOOL VALUES ====================================\\

  bool isChecked = false;
  var isObscured;

  //=========================== STYLE ====================================\\

  TextStyle myAccentFontStyle = TextStyle(
    color: kAccentColor,
  );

  //=========================== FOCUS NODES ====================================\\
  FocusNode userFirstNameFN = FocusNode();
  FocusNode userLastNameFN = FocusNode();
  FocusNode userEmailFN = FocusNode();
  FocusNode userPasswordFN = FocusNode();

  //=========================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        resizeToAvoidBottomInset: true,
        appBar: const MyAppBar(
          title: "",
          toolbarHeight: kToolbarHeight,
          backgroundColor: kTransparentColor,
          elevation: 0.0,
          actions: [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              ReusableAuthenticationFirstHalf(
                title: "Sign up",
                subtitle: "Please sign up to get started",
                decoration: BoxDecoration(),
                imageContainerHeight: 0,
              ),
              kSizedBox,
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        24,
                      ),
                      topRight: Radius.circular(
                        24,
                      ),
                    ),
                    color: kPrimaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
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
                                    'First Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(
                                        0xFF31343D,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                NameTextFormField(
                                  controller: userFirstNameEC,
                                  validator: (value) {
                                    RegExp userNamePattern = RegExp(
                                      r'^.{3,}$', //Min. of 3 characters
                                    );
                                    if (value == null || value!.isEmpty) {
                                      userFirstNameFN.requestFocus();
                                      return "Enter your first name";
                                    } else if (!userNamePattern
                                        .hasMatch(value)) {
                                      userFirstNameFN.requestFocus();
                                      return "Name must be at least 3 characters";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userFirstNameEC.text = value;
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
                                      color: Color(
                                        0xFF31343D,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                NameTextFormField(
                                  controller: userLastNameEC,
                                  validator: (value) {
                                    RegExp userNamePattern = RegExp(
                                      r'^.{3,}$', //Min. of 3 characters
                                    );
                                    if (value == null || value!.isEmpty) {
                                      userLastNameFN.requestFocus();
                                      return "Enter your last name";
                                    } else if (!userNamePattern
                                        .hasMatch(value)) {
                                      userLastNameFN.requestFocus();
                                      return "Name must be at least 3 characters";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userLastNameEC.text = value;
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
                                      color: Color(
                                        0xFF31343D,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                EmailTextFormField(
                                  controller: userEmailEC,
                                  emailFocusNode: userEmailFN,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    RegExp emailPattern = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                    );
                                    if (value == null || value!.isEmpty) {
                                      userEmailFN.requestFocus();
                                      return "Enter your email address";
                                    } else if (!emailPattern.hasMatch(value)) {
                                      userEmailFN.requestFocus();
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmailEC.text = value;
                                  },
                                ),
                                kSizedBox,
                                const SizedBox(
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF31343D,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                PasswordTextFormField(
                                  controller: userPasswordEC,
                                  passwordFocusNode: userPasswordFN,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: isObscured,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    RegExp passwordPattern = RegExp(
                                      r'^.{8,}$',
                                    );
                                    if (value == null || value!.isEmpty) {
                                      userPasswordFN.requestFocus();
                                      return "Enter your password";
                                    } else if (!passwordPattern
                                        .hasMatch(value)) {
                                      userPasswordFN.requestFocus();
                                      return "Password must be at least 8 characters";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPasswordEC.text = value;
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
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      splashRadius: 50,
                                      isError: true,
                                      activeColor: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "8-32 characters long",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      splashRadius: 50,
                                      isError: true,
                                      activeColor: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Has a lowercase character",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      splashRadius: 50,
                                      isError: true,
                                      activeColor: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Has an uppercase character",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      splashRadius: 50,
                                      isError: true,
                                      activeColor: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Has a Number",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      splashRadius: 50,
                                      isError: true,
                                      activeColor: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Has a special character",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBox,
                                ElevatedButton(
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      mySnackBar(
                                        context,
                                        "Sign up Successful",
                                        kSuccessColor,
                                        SnackBarBehavior.floating,
                                        kDefaultPadding,
                                      );
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpSplashScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kAccentColor,
                                    maximumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      62,
                                    ),
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      60,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ),
                                    ),
                                    elevation: 10,
                                    shadowColor: kDarkGreyColor,
                                  ),
                                  child: Text(
                                    "Sign up".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF646982,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Log in",
                                        style: myAccentFontStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                kHalfSizedBox,
                                Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Or sign up with ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(
                                            0xFF646982,
                                          ),
                                        ),
                                      ),
                                      kSizedBox,
                                      InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {},
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: kGreyColor1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/google-signup-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Google",
                                                style: TextStyle(
                                                  color: kTextBlackColor,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      kSizedBox,
                                    ],
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
