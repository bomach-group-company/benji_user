import 'package:benji_user/src/common_widgets/textformfield/card_expiry_textformfield.dart';
import 'package:benji_user/src/common_widgets/textformfield/flex_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
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
  final _scrollController = ScrollController();

  //=========================== KEYS ====================================\\
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController cardNumberEC = TextEditingController();
  TextEditingController expiryDateEC = TextEditingController();
  TextEditingController cvvEC = TextEditingController();
  TextEditingController cardHoldersFullNameEC = TextEditingController();
  TextEditingController cardMonthEC = TextEditingController();
  TextEditingController cardYearEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\

  FocusNode cardNumberFN = FocusNode();
  FocusNode expiryDateFN = FocusNode();
  FocusNode cvvFN = FocusNode();
  FocusNode cardHoldersFullNameFN = FocusNode();
  FocusNode rateVendorFN = FocusNode();
  FocusNode cardMonthFN = FocusNode();
  FocusNode cardYearFN = FocusNode();

  //=========================== VARIABLES ====================================\\

  int? _selectedOption = 0;

  //=========================== FUNCTIONS ====================================\\

  void _saveCard() {
    Get.back();
  }

  //=========================== WIDGETS ====================================\\

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Container(
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
          kHalfSizedBox,
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
          kSizedBox,
          MyOutlinedElevatedButton(
            title: 'Use a new Card',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kPrimaryColor,
                elevation: 20,
                barrierColor: kBlackColor.withOpacity(0.4),
                showDragHandle: true,
                useSafeArea: true,
                isScrollControlled: true,
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(kDefaultPadding),
                  ),
                ),
                enableDrag: true,
                builder: (context) => GestureDetector(
                  onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: kPrimaryColor,
                    body: Scrollbar(
                      controller: _scrollController,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Add new card',
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: MyCardExpiryTextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                onSaved: (value) {
                                                  cardYearEC.text = value!;
                                                },
                                                onChanged: (value) {
                                                  if (value.length == 2) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    cardMonthFN.requestFocus();
                                                    return "";
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: Text(
                                              ' / ',
                                              style: TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: MyCardExpiryTextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                onSaved: (value) {
                                                  cardYearEC.text = value!;
                                                },
                                                onChanged: (value) {
                                                  if (value.length == 2) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    cardYearFN.requestFocus();
                                                    return "";
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(flex: 1),
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
                                          } else if (!cvvPattern
                                              .hasMatch(value)) {
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
                                      return "Card Holder's full name";
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
                                  hintText: "Card Holder's full name",
                                ),
                                SizedBox(
                                  height: kDefaultPadding * 2,
                                ),
                                MyElevatedButton(
                                  title: "Continue",
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      _saveCard;
                                    }
                                  }),
                                ),
                                SizedBox(
                                  height: kDefaultPadding * 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
