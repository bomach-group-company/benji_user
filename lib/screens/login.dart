import 'package:alpha_logistics/theme/colors.dart';
import 'package:flutter/material.dart';

import '../modules/my floating snackbar.dart';
import '../reusable widgets/email textformfield.dart';
import '../reusable widgets/password textformfield.dart';
import '../reusable widgets/reusable authentication first half.dart';
import '../splash screens/login splash screen.dart';
import '../theme/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //===============================================================\\

//Strings
//   String errorMessage = "";

//TextEditingControllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//Formkey
  final _formKey = GlobalKey<FormState>();

//Bool Values
  bool isChecked = false;
  var isObscured;

  TextStyle myAccentFontStyle = TextStyle(
    color: kAccentColor,
  );

  //FocusNode
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              ReusableAuthenticationFirstHalf(
                image: "assets/images/login/avatar-image.png",
                title: "Log In",
                subtitle: "Please sign in to your existing account",
              ),
              kSizedBox,
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
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
                    padding: EdgeInsets.only(
                      left: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
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
                                SizedBox(
                                  width: 38.31,
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
                                      emailFocusNode.requestFocus();
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    emailController.text = value;
                                  },
                                ),
                                kSizedBox,
                                SizedBox(
                                  width: 61.72,
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
                                        ? Icon(
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
                                        Text(
                                          "Remember me",
                                          style: TextStyle(
                                            color: kTextGreyColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {},
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
                                              LoginSplashScreen(),
                                        ),
                                      );
                                    }
                                  }),
                                  child: Text(
                                    "Log in".toUpperCase(),
                                  ),
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
                                ),
                                kHalfSizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                        color: Color(
                                          0xFF646982,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
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
                                      Text(
                                        "Or sign up with ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(
                                            0xFF646982,
                                          ),
                                        ),
                                      ),
                                      kSizedBox,
                                      GestureDetector(
                                        onLongPress: () => null,
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
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/google-signup-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
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
