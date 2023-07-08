import 'package:alpha_logistics/reusable%20widgets/my%20textformfield.dart';
import 'package:flutter/material.dart';

import '../../modules/my floating snackbar.dart';
import '../../reusable widgets/my appbar.dart';
import '../../reusable widgets/my elevatedbutton.dart';
import '../../theme/colors.dart';
import '../../providers/constants.dart';

class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon({super.key});

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  //=============================== ALL VARIABLES ======================================\\

  //===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();

  //===================== CONTROLLERS =======================\\
  TextEditingController textController = TextEditingController();

  //===================== FOCUS NODES =======================\\
  FocusNode textFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Apply Coupon",
          backgroundColor: kPrimaryColor,
          actions: [],
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Coupon Code',
                      style: TextStyle(
                        color: Color(
                          0xFF333333,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  kSizedBox,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextFormField(
                          hintText: "Enter a coupon code",
                          controller: textController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: textFocusNode,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              textFocusNode.requestFocus();
                              return "Enter a coupon code";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            textController.text = value;
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding * 4,
                        ),
                        MyElevatedButton(
                          title: "Apply Coupon",
                          onPressed: (() async {
                            if (_formKey.currentState!.validate()) {
                              mySnackBar(
                                context,
                                "Coupon code applied",
                                kAccentColor,
                                SnackBarBehavior.floating,
                                kDefaultPadding,
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
