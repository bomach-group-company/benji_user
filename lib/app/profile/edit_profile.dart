// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/my_elevatedbutton.dart';
import '../../src/common_widgets/my_intl_phonefield.dart';
import '../../src/common_widgets/snackbar/my_fixed_snackBar.dart';
import '../../src/common_widgets/textformfield/email_textformfield.dart';
import '../../src/common_widgets/textformfield/message_textformfield.dart';
import '../../src/common_widgets/textformfield/name_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
//======================================== ALL VARIABLES ==============================================\\

//======================================== GLOBAL KEYS ==============================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== CONTROLLERS ====================================\\

  TextEditingController userFirstNameEC = TextEditingController();
  TextEditingController userLastNameEC = TextEditingController();
  TextEditingController userEmailEC = TextEditingController();
  TextEditingController phoneNumberEC = TextEditingController();
  TextEditingController bioEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\
  FocusNode userFirstNameFN = FocusNode();
  FocusNode userLastNameFN = FocusNode();
  FocusNode userEmailFN = FocusNode();
  FocusNode phoneNumberFN = FocusNode();
  FocusNode messageFN = FocusNode();

  //=========================== BOOL VALUES ====================================\\
  bool isLoading = false;

  //=========================== IMAGE PICKER ====================================\\

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  //=========================== WIDGETS ====================================\\
  Widget profilePicBottomSheet() {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile photo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(80),
                onTap: () {},
                child: Icon(
                  Icons.delete_rounded,
                  color: kAccentColor,
                ),
              ),
            ],
          ),
          kSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickProfilePic(ImageSource.camera);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            width: 0.5,
                            color: kGreyColor1,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  Text(
                    "Camera",
                  ),
                ],
              ),
              kWidthSizedBox,
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickProfilePic(ImageSource.gallery);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            width: 0.5,
                            color: kGreyColor1,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  Text(
                    "Gallery",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //=========================== FUNCTIONS ====================================\\
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(Duration(seconds: 2));

    //Display snackBar
    myFixedSnackBar(
      context,
      "Your changes have been saved successfully".toUpperCase(),
      kSecondaryColor,
      Duration(
        seconds: 2,
      ),
    );

    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      // Navigate to the new page
      Navigator.of(context).pop(context);
    });

    setState(() {
      isLoading = false;
    });
  }

  pickProfilePic(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
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
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        bottomNavigationBar: isLoading
            ? Center(
                child: SpinKitChasingDots(
                  color: kAccentColor,
                  duration: const Duration(seconds: 2),
                ),
              )
            : Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: MyElevatedButton(
                  onPressed: (() async {
                    if (_formKey.currentState!.validate()) {
                      loadData();
                    }
                  }),
                  title: "Save",
                ),
              ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(100),
                          child: selectedImage == null
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Color(0xFFF8D1D1),
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(
                                    selectedImage!,
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                elevation: 20,
                                barrierColor: kBlackColor.withOpacity(
                                  0.8,
                                ),
                                showDragHandle: true,
                                useSafeArea: true,
                                isDismissible: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      kDefaultPadding,
                                    ),
                                  ),
                                ),
                                enableDrag: true,
                                builder: (builder) => profilePicBottomSheet(),
                              );
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: ShapeDecoration(
                                color: kAccentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        } else if (!userNamePattern.hasMatch(value)) {
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
                    Text(
                      "Last Name".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kHalfSizedBox,
                    NameTextFormField(
                      controller: userLastNameEC,
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
                        userLastNameEC.text = value;
                      },
                      textInputAction: TextInputAction.next,
                      nameFocusNode: userLastNameFN,
                    ),
                    kSizedBox,
                    Text(
                      "Email".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                    Text(
                      "Phone Number".toUpperCase(),
                      style: TextStyle(
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
                    Text(
                      "BIO".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kHalfSizedBox,
                    MyMessageTextFormField(
                      controller: bioEC,
                      textInputAction: TextInputAction.newline,
                      focusNode: messageFN,
                      hintText: "Enter your bio",
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value!.isEmpty) {
                          messageFN.requestFocus();
                          return "Enter your Bio";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        bioEC.text = value;
                      },
                      maxLength: 6000,
                    ),
                  ],
                ),
              ),
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
