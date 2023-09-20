import 'dart:developer';

import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji_user/src/common_widgets/textformfield/number_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monnify_payment_sdk/monnify_payment_sdk.dart';

import '../../src/providers/constants.dart';

class MonnifyPaymentSDK extends StatefulWidget {
  const MonnifyPaymentSDK({super.key});

  @override
  State<MonnifyPaymentSDK> createState() => _MonnifyPaymentSDKState();
}

class _MonnifyPaymentSDKState extends State<MonnifyPaymentSDK> {
  //============================== INITIAl STATE AND DISPOSE ========================\\
  @override
  void initState() {
    initializeMonnify();
    super.initState();
  }

//==================\\

  final _controllerEC = TextEditingController();
  // ..text = '20';
  FocusNode _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey();
  late Monnify? monnify;

  void showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  void initializeMonnify() async {
    monnify = await Monnify.initialize(
      applicationMode: ApplicationMode.TEST,
      apiKey: 'MK_TEST_DYCSAYYZKC',
      contractCode: '7244830854',
    );
  }

  void onInitializePayment() async {
    final amount = double.parse(_controllerEC.text);
    final paymentReference = DateTime.now().millisecondsSinceEpoch.toString();

    final transaction = TransactionDetails().copyWith(
      amount: amount,
      currencyCode: 'NGN',
      customerName: 'Daniel Chigozie',
      customerEmail: 'custo.mer@email.com',
      paymentReference: paymentReference,
      // metaData: {"ip": "196.168.45.22", "device": "mobile"},
      // paymentMethods: [PaymentMethod.CARD, PaymentMethod.ACCOUNT_TRANSFER, PaymentMethod.USSD],
      /*incomeSplitConfig: [SubAccountDetails("MFY_SUB_319452883968", 10.5, 500, true),
          SubAccountDetails("MFY_SUB_259811283666", 10.5, 1000, false)]*/
    );

    try {
      final response =
          await monnify?.initializePayment(transaction: transaction);

      print(response.toString());
      showToast(response.toString());
      print(response.toString());
      log(response.toString());
      print(response.toString());
    } catch (e) {
      log('$e');
      showToast(e.toString());
      print(e.toString());
    }
  }

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
                    controller: _controllerEC,
                    validator: (value) {
                      return null;
                    },
                    textInputAction: TextInputAction.go,
                    focusNode: _focusNode,
                    hintText: "Enter the amount",
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  kSizedBox,
                  MyElevatedButton(
                    title: "Pay",
                    onPressed: (() async {
                      if (_formKey.currentState!.validate()) {
                        onInitializePayment();
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
