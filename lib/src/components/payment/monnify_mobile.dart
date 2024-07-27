import 'dart:convert';

import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MonnifyWidgetMobile extends StatefulWidget {
  final String apiKey;
  final String contractCode;
  final Map? metaData;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String currency;
  final String amount;
  final Function(dynamic response) onTransaction;
  final Function()? onClose;
  const MonnifyWidgetMobile({
    super.key,
    required this.apiKey,
    required this.contractCode,
    this.metaData,
    required this.email,
    this.phone = '',
    this.firstName = '',
    this.lastName = '',
    this.currency = 'NGN',
    required this.amount,
    required this.onTransaction,
    this.onClose,
  });

  @override
  MonnifyWidgetMobileState createState() => MonnifyWidgetMobileState();
}

class MonnifyWidgetMobileState extends State<MonnifyWidgetMobile> {
  late final WebViewController _controller;

  String html = "";

  late String metaData;
  late String apiKey;
  late String contractCode;
  late String email;
  late String phone;
  late String fullname;
  late String currency;
  late String amount;

  callit() {
    try {
      _controller.runJavaScript('''
MonnifySDK.initialize({
              amount: $amount,
              currency: $currency,
              reference: new String((new Date()).getTime()),
              customerFullName: $fullname,
              customerEmail: $email,
              apiKey: $apiKey,
              contractCode: $contractCode,
              paymentDescription: "Order Payment",
              metadata: $metaData,
              incomeSplitConfig: [],
              onLoadStart: () => {
                  console.log("loading has started");
              },
              onLoadComplete: () => {
                  console.log("SDK is UP");
              },
              onComplete: function(response) {
                  //Implement what happens when the transaction is completed.
                  console.log(response);
                  paymentsuccess.postMessage(JSON.stringify(response));
              },
              onClose: function(data) {
                  //Implement what should happen when the modal is closed here
                  console.log(data);
                  paymentcancel.postMessage("payment cancel");
              }
          });
''');
    } catch (e) {
      ApiProcessorController.errorSnack("Yet to load please try again");
      Get.close(1);
      print(e);
      print('error in loading payment modal');
    }
  }

  @override
  void initState() {
    super.initState();

    metaData = widget.metaData == null ? 'null' : jsonEncode(widget.metaData);
    apiKey = '"${widget.apiKey}"';
    contractCode = '"${widget.contractCode}"';
    email = '"${widget.email}"';
    phone = '"${widget.phone}"';
    fullname = '"${widget.firstName} ${widget.lastName}"';
    currency = '"${widget.currency}"';
    amount = widget.amount;

    html = """
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="https://sdk.monnify.com/plugin/monnify.js"></script>

</head>
<body>
   
</body>
</html>
""";

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'paymentsuccess',
        onMessageReceived: (JavaScriptMessage message) {
          dynamic resp = jsonDecode(message.message);
          widget.onTransaction(resp);
        },
      )
      ..addJavaScriptChannel(
        'paymentcancel',
        onMessageReceived: (JavaScriptMessage message) {
          if (widget.onClose == null) {
            Navigator.pop(context);
          } else {
            widget.onClose!();
          }
        },
      )
      ..loadHtmlString(html)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            callit();
          },
        ),
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: "Pay with Monnify",
        actions: const [],
      ),
      body: Center(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
