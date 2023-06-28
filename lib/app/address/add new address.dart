import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20outlined%20elevatedbutton.dart';
import 'package:flutter/material.dart';

import '../../modules/my floating snackbar.dart';
import '../../reusable widgets/my textformfield.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  //=================================== ALL VARIABLES =====================================\\

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode addressTitleFocusNode = FocusNode();
  FocusNode recipientNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 2.0,
          title: "New Address ",
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title (My Home, My Office)',
                              style: TextStyle(
                                color: Color(
                                  0xFF333333,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText:
                                  "Enter address name tag e.g my work, my home....",
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: addressTitleFocusNode,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  addressTitleFocusNode.requestFocus();
                                  return "Enter a title";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                addressTitleController.text = value;
                              },
                            ),
                            kHalfSizedBox,
                            Text(
                              'Name tag of this address e.g my work, my apartment',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                  0xFF4C4C4C,
                                ),
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recipient Name',
                              style: TextStyle(
                                color: Color(
                                  0xFF333333,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "Enter recipient name",
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: recipientNameFocusNode,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameController.text = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Street Address',
                              style: TextStyle(
                                color: Color(
                                  0xFF333333,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "Enter a street address",
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.streetAddress,
                              focusNode: recipientNameFocusNode,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameController.text = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recipient Name',
                              style: TextStyle(
                                color: Color(
                                  0xFF333333,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "Enter recipient name",
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: recipientNameFocusNode,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameController.text = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recipient Name',
                              style: TextStyle(
                                color: Color(
                                  0xFF333333,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            MyTextFormField(
                              hintText: "Enter recipient name",
                              controller: recipientNameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              focusNode: recipientNameFocusNode,
                              validator: (value) {
                                //username pattern
                                //Min. of 3 characters
                                RegExp userNamePattern = RegExp(
                                  r'^.{3,}$',
                                );
                                if (value == null || value!.isEmpty) {
                                  recipientNameFocusNode.requestFocus();
                                  return "Enter your name";
                                } else if (!userNamePattern.hasMatch(value)) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                recipientNameController.text = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      kSizedBox,
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 6,
              ),
              MyOutlinedElevatedButton(
                title: "Set As Default Address",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(context);
                    mySnackBar(
                      context,
                      "Set As Default Address",
                      kAccentColor,
                      SnackBarBehavior.floating,
                      kDefaultPadding,
                    );
                  }
                }),
              ),
              kSizedBox,
              MyElevatedButton(
                title: "Save New Address",
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(context);
                    mySnackBar(
                      context,
                      "Address saved",
                      kAccentColor,
                      SnackBarBehavior.floating,
                      kDefaultPadding,
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
