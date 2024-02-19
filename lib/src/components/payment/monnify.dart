// ignore_for_file: unnecessary_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MonnifyWidget extends StatefulWidget {
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
  const MonnifyWidget({
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
  MonnifyWidgetState createState() => MonnifyWidgetState();
}

class MonnifyWidgetState extends State<MonnifyWidget> {
  late final WebViewController _controller;

  String html = "";
  @override
  void initState() {
    super.initState();

    String metaData =
        widget.metaData == null ? 'null' : jsonEncode(widget.metaData);
    String apiKey = '"${widget.apiKey}"';
    String contractCode = '"${widget.contractCode}"';
    String email = '"${widget.email}"';
    String phone = '"${widget.phone}"';
    String fullname = '"${widget.firstName} ${widget.lastName}"';
    String currency = '"${widget.currency}"';
    String amount = widget.amount;

    html = """
<html>
<head>
    <script type="text/javascript" src="https://sdk.monnify.com/plugin/monnify.js"></script>
    <script>
        function payWithMonnify() {
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
                    //paymentsuccess(JSON.stringify(response));
                },
                onClose: function(data) {
                    //Implement what should happen when the modal is closed here
                    console.log(data);
                    // paymentcancel("payment cancel");
                }
            });
        }
        payWithMonnify();
    </script>
</head>
<body>
     <!-- <div>
        <button type="button" onclick="payWithMonnify()">Pay With Monnify</button>
    </div> -->
</body>
</html>
""";

    // #docregion platform_features
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
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'paymentsuccess',
        onMessageReceived: (JavaScriptMessage message) {
          print('Payment success: ${message.message}');
          dynamic resp = jsonDecode(message.message);
          widget.onTransaction(resp);
        },
      )
      ..addJavaScriptChannel(
        'paymentcancel',
        onMessageReceived: (JavaScriptMessage message) {
          print('Payment canceled: ${message.message}');
          if (widget.onClose == null) {
            Navigator.pop(context);
          } else {
            widget.onClose!();
          }
        },
      )
      ..loadHtmlString(html,
          baseUrl: 'https://sdk.monnify.com/plugin/monnify.js');

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      // Look here!
      child: WebViewWidget(controller: _controller),
    ));
  }
}


// WebView(
//         initialUrl: 'about:blank',
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           webViewController.loadUrl(Uri.dataFromString(html,
//                   mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//               .toString());
//         },
//         javascriptChannels: <JavascriptChannel>{
//           JavascriptChannel(
//             name: 'paymentsuccess',
//             onMessageReceived: (JavascriptMessage message) {
//               print('Payment success: ${message.message}');
//               dynamic resp = jsonDecode(message.message);
//               widget.onTransaction(resp);
//             },
//           ),
//           JavascriptChannel(
//             name: 'paymentcancel',
//             onMessageReceived: (JavascriptMessage message) {
//               print('Payment canceled: ${message.message}');
//               if (widget.onClose == null) {
//                 Navigator.pop(context);
//               } else {
//                 widget.onClose!();
//               }
//             },
//           ),
//         },
//       ),