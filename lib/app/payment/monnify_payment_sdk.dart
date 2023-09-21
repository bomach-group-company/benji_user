import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';

class MonnifyPaymentSDK extends StatefulWidget {
  const MonnifyPaymentSDK({super.key});

  @override
  State<MonnifyPaymentSDK> createState() => _MonnifyPaymentSDKState();
}

class _MonnifyPaymentSDKState extends State<MonnifyPaymentSDK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
