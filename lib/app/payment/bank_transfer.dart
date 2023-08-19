import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/my_floating_snackbar.dart';
import '../../src/common_widgets/my_outlined_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../splash_screens/payment_successful_screen.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({super.key});

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
//===================== COPY TO CLIPBOARD =======================\\
  final String userID = '9926374776';
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: userID,
      ),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      "Success!",
      "Copied to clipboard",
      Duration(
        seconds: 2,
      ),
    );
  }

  void _paymentSuccess() {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kSizedBox,
                Text(
                  'Bank Transfer',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                kSizedBox,
                Text(
                  'Please transfer money directory  to the bank account below',
                  style: TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kSizedBox,
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACCOUNT NUMBER',
                        style: TextStyle(
                          color: Color(0xFF929292),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      Text(
                        '9926374776',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: kAccentColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: kAccentColor,
                      ),
                    ),
                    onPressed: () {
                      _copyToClipboard(context);
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.copy,
                          color: kAccentColor,
                          size: 18,
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          'copy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kAccentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.bakery_dining_sharp,
                    color: kAccentColor,
                    size: 40,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BANK NAME\n',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Guarantee Trust Bank',
                        style: TextStyle(
                          color: Color(0xFF181C2E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACCOUNT NAME',
                        style: TextStyle(
                          color: Color(0xFF50555C),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Leticia Ikaegbu',
                        style: TextStyle(
                          color: Color(0xFF181C2E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding * 2.5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Pay: NGN 2,450',
                  style: TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              kSizedBox,
              MyOutlinedElevatedButton(
                  onPressed: _paymentSuccess, title: 'I have made the transfer')
            ],
          )
        ],
      ),
    );
  }
}
