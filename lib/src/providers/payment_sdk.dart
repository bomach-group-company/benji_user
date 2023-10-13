import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_squad/flutter_squad.dart';

class SquadExample extends StatefulWidget {
  const SquadExample({super.key});

  @override
  State<SquadExample> createState() => _SquadExampleState();
}

class _SquadExampleState extends State<SquadExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Pay With Squad"),
              onPressed: () async {
                SquadTransactionResponse? response = await Squad.checkout(
                    context, charge(),
                    sandbox: true,
                    showAppbar: false,
                    appBar: AppBarConfig(
                        color: Colors.green,
                        leadingIcon: const Icon(Icons.close)));
                debugPrint(
                    "Squad transaction completed======>${response?.toJson().toString()}");
              },
            ),
          ],
        ),
      ),
    ));
  }

  Charge charge() {
    return Charge(
        amount: 10000,
        publicKey: "sandbox_pk_a7ce8374b818a8e2b670027f256b7d53ec0645dc7a3b1",
        secretKey: "sandbox_sk_a7ce8374b818a8e2b670127f5f6f7133f30a25a50d3d1",
        email: "emma@yopmail.com",
        currencyCode: "NGN",
        transactionRef: "SQUAD-PYM-${generateRandomString(10)}",
        paymentChannels: ["card", "bank", "ussd", "transfer"],
        customerName: "Emmanuel Izedomi",
        callbackUrl: null,
        metadata: {"name": "Damilare", "age": 45},
        passCharge: false);
  }

  String generateRandomString(int len) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        len, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
