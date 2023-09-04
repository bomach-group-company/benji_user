import 'dart:convert';
import 'dart:math';

import 'package:benji_user/src/repo/models/product/product.dart';
import 'package:benji_user/src/repo/models/user/user_model.dart';
import 'package:benji_user/src/repo/utils/base_url.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../snackbar/my_floating_snackbar.dart';
import '../textformfield/message_textformfield.dart';

class RateProductDialog extends StatefulWidget {
  final Product product;
  const RateProductDialog({super.key, required this.product});

  @override
  State<RateProductDialog> createState() => _RateProductDialogState();
}

class _RateProductDialogState extends State<RateProductDialog> {
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
  Future<bool> rate() async {
    User? user = await getUser();
    final url = Uri.parse('$baseURL/products/productReviewsRating');

    Map body = {
      'client_id': user!.id,
      'vendor_id': widget.product.vendorId.id,
      'rating_value': _rating,
      'comment': _myMessageEC.text,
    };
    print(body);

    final response =
        await http.post(url, body: body, headers: await authHeader());
    print(response.body);
    print(response.statusCode);
    try {
      Map resp = jsonDecode(response.body);
      bool res = response.statusCode == 200;
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<void> _submitRequest() async {
    await checkAuth(context);

    setState(() {
      _submittingRequest = true;
    });
    bool res = await rate();
    if (res) {
      //Display snackBar
      mySnackBar(
        context,
        kSuccessColor,
        "Success",
        "Your review has been submitted successfully",
        const Duration(seconds: 1),
      );
      setState(() {
        _submittingRequest = false;
      });
      //Go back;
      Get.back();
    } else {
      mySnackBar(
        context,
        kAccentColor,
        "Failed",
        "An error occurred",
        const Duration(seconds: 1),
      );
      setState(() {
        _submittingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: AnimatedContainer(
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
        "Rate this product",
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
