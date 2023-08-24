import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../snackbar/my_floating_snackbar.dart';
import '../textformfield/message_textformfield.dart';

class RateVendorDialog extends StatefulWidget {
  const RateVendorDialog({super.key});

  @override
  State<RateVendorDialog> createState() => _RateVendorDialogState();
}

class _RateVendorDialogState extends State<RateVendorDialog> {
//===================================== ALL VARIABLES ======================================\\
  var _starPosition = 200.0;
  var _rating = 0.0;

//===================================== BOOL VALUES ======================================\\
  bool _pageChanged = false;
  bool _submittingRequest = false;

//===================================== KEYS ======================================\\
  var _formKey = GlobalKey<FormState>();

//===================================== CONTROLLERS ======================================\\
  var _ratingPageController = PageController();
  var _myMessageEC = TextEditingController();

//===================================== FOCUS NODES ======================================\\
  var _myMessageFN = FocusNode();

//===================================== FUNCTIONS ======================================\\
  Future<void> _submitRequest() async {
    setState(() {
      _submittingRequest = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    //Display snackBar
    mySnackBar(
      context,
      "Success",
      "Your review has been submitted successfully",
      const Duration(seconds: 1),
    );

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _submittingRequest = false;
      });

      //Go back;
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            height: _pageChanged
                ? max(300, mediaHeight * 0.5)
                : max(300, mediaHeight * 0.3),
            padding: EdgeInsets.all(kDefaultPadding),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _submittingRequest
                    ? SpinKitChasingDots(color: kAccentColor)
                    : _causeOfRating(
                        _myMessageEC,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return "Field cannot be left empty";
                          }
                          return null;
                        },
                        _myMessageFN,
                        _formKey,
                      ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: _pageChanged == false ? kGreyColor1 : kAccentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kDefaultPadding),
                  bottomRight: Radius.circular(kDefaultPadding),
                ),
              ),
              child: _pageChanged == false
                  ? MaterialButton(
                      enableFeedback: true,
                      onPressed: null,
                      child: Text(
                        "Done",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      disabledElevation: 0.0,
                      disabledColor: kGreyColor1,
                      disabledTextColor: kTextBlackColor,
                      mouseCursor: SystemMouseCursors.click,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(kDefaultPadding),
                          bottomRight: Radius.circular(kDefaultPadding),
                        ),
                      ),
                    )
                  : MaterialButton(
                      enableFeedback: true,
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          _submitRequest();
                        }
                      }),
                      child: Text(
                        "Done",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      mouseCursor: SystemMouseCursors.click,
                      color: kAccentColor,
                      height: 50,
                      focusElevation: kDefaultPadding,
                      focusColor: kAccentColor,
                      hoverElevation: 10.0,
                      hoverColor: kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(kDefaultPadding),
                          bottomRight: Radius.circular(kDefaultPadding),
                        ),
                      ),
                    ),
            ),
          ),
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            duration: Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    _ratingPageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );

                    setState(
                      () {
                        _starPosition = 10.0;
                        _rating = index + 1;
                        _pageChanged = true;
                      },
                    );
                  },
                  color: kStarColor,
                  icon: index < _rating
                      ? FaIcon(FontAwesomeIcons.solidStar, size: 30)
                      : FaIcon(FontAwesomeIcons.star, size: 26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_buildThanksNote() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "We'd love to get your feedback",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: kAccentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      kHalfSizedBox,
      Text(
        "Rate this vendor",
      ),
    ],
  );
}

_causeOfRating(
  final TextEditingController controller,
  final FormFieldValidator validator,
  final FocusNode focusNode,
  final Key _formKey,
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Visibility(
        visible: true,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("What could be better?"),
              kHalfSizedBox,
              MyMessageTextFormField(
                controller: controller,
                validator: validator,
                textInputAction: TextInputAction.newline,
                focusNode: focusNode,
                hintText: "Enter your review (required)",
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                maxLength: 6000,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
