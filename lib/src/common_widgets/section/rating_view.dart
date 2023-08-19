import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../textformfield/message_textformfield.dart';

class RatingView extends StatefulWidget {
  const RatingView({super.key});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
//===================================== ALL VARIABLES ======================================\\
  var _starPosition = 200.0;
  var _rating = 0.0;

//===================================== BOOL VALUES ======================================\\
  bool _pageChanged = false;

//===================================== KEYS ======================================\\
  // var _formKey = GlobalKey<FormState>();

//===================================== CONTROLLERS ======================================\\
  var _ratingPageController = PageController();
  var _myMessageEC = TextEditingController();

//===================================== FOCUS NODES ======================================\\
  var _myMessageFN = FocusNode();
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Container(
            height: max(300, mediaHeight * 0.3),
            padding: EdgeInsets.all(kDefaultPadding),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(
                  _myMessageEC,
                  (value) {
                    return null;
                  },
                  _myMessageFN,
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
                color: kAccentColor,
              ),
              child: _pageChanged == false
                  ? MaterialButton(
                      enableFeedback: true,
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    )
                  : MaterialButton(
                      enableFeedback: true,
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: kPrimaryColor),
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
                        _starPosition = 30.0;
                        _rating = index + 1;
                        _pageChanged = true;
                      },
                    );
                  },
                  color: kAccentColor,
                  icon: index < _rating
                      ? Icon(Icons.star_rounded, size: 32)
                      : Icon(Icons.star_outline_rounded, size: 32),
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
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Visibility(
        visible: true,
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
              hintText: "Enter your review (Optional)",
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              maxLength: 6000,
            ),
          ],
        ),
      ),
    ],
  );
}
