// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;
// import 'package:js/js.dart' as js;

class SquadPopup {
  static Future<void> openSquadPopup({
    required Function() onClose,
    required Function() onLoad,
    required Function(dynamic resp) onSuccess,
    required String email,
    required String amount,
    required String currencycode,
    required String customername,
  }) async {
    js.context.callMethod(
      'SquadPay',
      [
        onClose,
        onLoad,
        onSuccess,
        'sandbox_pk_416415c8a3d27e85e971a3d0475734442ffbb124b579',
        email,
        amount,
        currencycode,
        customername,
      ],
    );
  }
}
