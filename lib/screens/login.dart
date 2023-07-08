// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../providers/constants.dart';
import '../reusable widgets/email textformfield.dart';
import '../reusable widgets/my floating snackbar.dart';
import '../reusable widgets/password textformfield.dart';
import '../reusable widgets/reusable authentication first half.dart';
import '../splash screens/login splash screen.dart';
import '../theme/colors.dart';
import 'forgot password.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

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
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              ReusableAuthenticationFirstHalf(
                title: "Log In",
                subtitle: "Please log in to your existing account",
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/login/avatar-image.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      43.50,
                    ),
                  ),
                ),
                imageContainerHeight: 88,
              ),
              kSizedBox,
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
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
                                      color: Color(
                                        0xFF31343D,
                                      ),
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
                                  obscureText: isObscured,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    RegExp passwordPattern = RegExp(
                                      r'^.{8,}$',
                                    );
                                    if (value == null || value!.isEmpty) {
                                      passwordFocusNode.requestFocus();
                                      return "Enter your password";
                                    } else if (!passwordPattern
                                        .hasMatch(value)) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          value: isChecked,
                                          splashRadius: 50,
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
                                        const Text("Remember me ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password",
                                        style: myAccentFontStyle,
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
                                        "Login Successful",
                                        kSuccessColor,
                                        SnackBarBehavior.floating,
                                        kDefaultPadding,
                                      );
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginSplashScreen(),
                                        ),
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
                                    // fixedSize: Size(
                                    //   MediaQuery.of(context).size.width,
                                    //   62,
                                    // ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ),
                                    ),
                                    elevation: 10,
                                    shadowColor: kDarkGreyColor,
                                  ),
                                  child: Text(
                                    "Log in".toUpperCase(),
                                  ),
                                ),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF646982,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Sign up",
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
                                        "Or log in with ",
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
