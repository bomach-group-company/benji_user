import 'package:flutter/material.dart';
import 'package:benji_user/src/common_widgets/textformfield/flex_textfield.dart';

import '../../src/common_widgets/my_elevatedbutton.dart';
import '../../src/common_widgets/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/textformfield/name_textformfield.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({super.key});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  //=========================== CONTROLLER ====================================\\

  TextEditingController cardNumberEC = TextEditingController();
  TextEditingController expiryDateEC = TextEditingController();
  TextEditingController cvvEC = TextEditingController();
  TextEditingController cardHoldersFullNameEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\

  FocusNode cardNumberFN = FocusNode();
  FocusNode expiryDateFN = FocusNode();
  FocusNode cvvFN = FocusNode();
  FocusNode cardHoldersFullNameFN = FocusNode();
  FocusNode rateVendorFN = FocusNode();

  //=========================== Var ====================================\\

  int? _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFFF0F0F0)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
              leading: Icon(
                Icons.credit_card,
                color: kAccentColor,
                size: 40,
              ),
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visa ***1234',
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 17.50,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.35,
                    ),
                  ),
                  kHalfSizedBox,
                  SizedBox(
                    width: mediaWidth / 3,
                    child: Text(
                      'Benard Okechukwu Expires 01/2024',
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                ],
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
              )),
          kHalfSizedBox,
          ListTile(
              leading: Icon(
                Icons.credit_card,
                color: kGreyColor,
                size: 40,
              ),
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visa ***1234',
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 17.50,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.35,
                    ),
                  ),
                  kHalfSizedBox,
                  SizedBox(
                    width: mediaWidth / 3,
                    child: Text(
                      'Benard Okechukwu Expires 01/2024',
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                ],
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
              )),
          kSizedBox,
          MyOutlinedElevatedButton(
            title: 'Use a new Card',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kPrimaryColor,
                elevation: 20,
                barrierColor: kBlackColor.withOpacity(
                  0.2,
                ),
                showDragHandle: true,
                useSafeArea: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                isScrollControlled: true,
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      kDefaultPadding,
                    ),
                  ),
                ),
                enableDrag: true,
                builder: (context) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  // color: kAccentColor,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          8,
                        ),
                        child: Text(
                          'Add new card',
                          style: TextStyle(
                            color: Color(0xFF454545),
                            fontSize: 24,
                            fontFamily: 'Sen',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      kSizedBox,
                      NameTextFormField(
                        controller: cardNumberEC,
                        validator: (value) {
                          RegExp cardPattern = RegExp(
                            r"^(?:\d{4}-\d{4}-\d{4}-\d{4}|\d{16}|\d{18})$",
                          );
                          if (value == null || value!.isEmpty) {
                            cardNumberFN.requestFocus();
                            return "Card Number";
                          } else if (!cardPattern.hasMatch(value)) {
                            cardNumberFN.requestFocus();
                            return "Invalid Card number";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cardNumberEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: cardNumberFN,
                        hintText: "Card Number",
                      ),
                      kSizedBox,
                      Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: MyFlexTextFormField(
                              controller: expiryDateEC,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                expiryDateEC.text = value;
                              },
                              validator: (value) {
                                RegExp datePattern = RegExp(
                                  r"^(0[1-9]|1[0-2])\/(2[2-9]|[3-9]\d)$",
                                );
                                if (value == null || value!.isEmpty) {
                                  expiryDateFN.requestFocus();
                                  return "Expiry date";
                                } else if (!datePattern.hasMatch(value)) {
                                  expiryDateFN.requestFocus();
                                  return "Invalid date";
                                }
                                return null;
                              },
                              hintText: 'Expiry date',
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 10,
                            child: MyFlexTextFormField(
                              controller: cvvEC,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                cvvEC.text = value;
                              },
                              validator: (value) {
                                RegExp cvvPattern = RegExp(
                                  r"^\d{3,4}$",
                                );
                                if (value == null || value!.isEmpty) {
                                  cvvFN.requestFocus();
                                  return "CVV";
                                } else if (!cvvPattern.hasMatch(value)) {
                                  cvvFN.requestFocus();
                                  return "Invalid CVV";
                                }
                                return null;
                              },
                              hintText: 'CVV',
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      NameTextFormField(
                        controller: cardHoldersFullNameEC,
                        validator: (value) {
                          RegExp cardPattern = RegExp(
                            r"^[A-Za-z]+(?:\s+[A-Za-z]+)*$",
                          );
                          if (value == null || value!.isEmpty) {
                            cardNumberFN.requestFocus();
                            return "Card Holder’s full name";
                          } else if (!cardPattern.hasMatch(value)) {
                            cardNumberFN.requestFocus();
                            return "Invalid Name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cardHoldersFullNameEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: cardHoldersFullNameFN,
                        hintText: "Card Holder’s full name",
                      ),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      MyElevatedButton(
                        title: "Continue",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
