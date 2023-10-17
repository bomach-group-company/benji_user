import 'package:js/js.dart';

@JS()
external SquadPay(
  Function() onClose,
  Function() onLoad,
  Function() onSuccess,
  String key,
  String email,
  String amount,
  String currencycode,
);
