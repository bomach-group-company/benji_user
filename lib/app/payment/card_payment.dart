import 'package:benji_user/app/payment/add_card.dart';
import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../splash_screens/payment_successful_screen.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({super.key});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  //=========================== CONTROLLER ====================================\\

  //=========================== VARIABLES ====================================\\

  int? _selectedOption = 0;

  //=========================== BOOL VALUES ====================================\\
  bool _processingPayment = false;

  //=========================== FUNCTIONS ====================================\\
  void _paymentFunc() async {
    setState(() {
      _processingPayment = true;
    });

    //Simulate a delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _processingPayment = false;
    });

    Get.to(
      () => const PaymentSuccessful(),
      routeName: 'PaymentSuccessful',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  //=========================== Navigation ====================================\\
  void _addNewCard() => Get.to(
        () => const AddNewCard(),
        routeName: 'AddNewCard',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: kLightGreyColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.solidCreditCard,
                  color: _selectedOption == 0 ? kAccentColor : kGreyColor1,
                  size: 30,
                ),
                contentPadding: EdgeInsets.zero,
                title: SizedBox(
                  width: mediaWidth / 1.2,
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Mastercard",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                        TextSpan(
                          text: "****1234",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                subtitle: SizedBox(
                  width: mediaWidth / 1.2,
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Benard Okechukwu",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                        TextSpan(
                          text: " Expires ",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                        TextSpan(
                          text: "01/2024",
                          style: TextStyle(
                            color: _selectedOption == 0
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                trailing: Radio(
                  activeColor: kAccentColor,
                  value: 0,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.solidCreditCard,
                  color: _selectedOption == 1 ? kAccentColor : kGreyColor1,
                  size: 30,
                ),
                contentPadding: EdgeInsets.zero,
                title: SizedBox(
                  width: mediaWidth / 1.2,
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Visa",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                        TextSpan(
                          text: "****1234",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                subtitle: SizedBox(
                  width: mediaWidth / 1.2,
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Benard Okechukwu",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                        TextSpan(
                          text: " Expires ",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                        TextSpan(
                          text: "01/2024",
                          style: TextStyle(
                            color: _selectedOption == 1
                                ? kTextBlackColor
                                : kTextGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                trailing: Radio(
                  activeColor: kAccentColor,
                  value: 1,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: kDefaultPadding * 2),
        _processingPayment
            ? SpinKitChasingDots(color: kAccentColor)
            : MyElevatedButton(
                title: "Make payment",
                onPressed: _paymentFunc,
              ),
        kSizedBox,
        MyOutlinedElevatedButton(
          title: 'Add a new Card',
          onPressed: _addNewCard,
        ),
      ],
    );
  }
}
