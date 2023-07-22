// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../providers/constants.dart';
import '../../reusable widgets/my elevatedbutton.dart';
import '../orders/track order.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/animations/successful/successful-payment.gif",
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Container(
                width: 297,
                child: Text(
                  'Thank You!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(
                      0xFF333333,
                    ),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
              kSizedBox,
              SizedBox(
                width: 307,
                child: Text(
                  'Your payment is successful',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(
                      0xFF676565,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.36,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              MyElevatedButton(
                title: "Done",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TrackOrder(),
                    ),
                  );
                },
              ),
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
