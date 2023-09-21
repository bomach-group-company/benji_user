import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji_user/src/common_widgets/textformfield/number_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../src/providers/constants.dart';

class MonnifyPaymentSDK extends StatefulWidget {
  const MonnifyPaymentSDK({super.key});

  @override
  State<MonnifyPaymentSDK> createState() => _MonnifyPaymentSDKState();
}

class _MonnifyPaymentSDKState extends State<MonnifyPaymentSDK> {
  final _priceEC = TextEditingController();
  final _priceFN = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Future<void> _initializePayment() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumberTextFormField(
                    controller: _priceEC,
                    validator: (value) {
                      return null;
                    },
                    textInputAction: TextInputAction.go,
                    focusNode: _priceFN,
                    hintText: "Enter an amount",
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  MyElevatedButton(
                      title: "Pay",
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          await _initializePayment();
                        }
                      }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
