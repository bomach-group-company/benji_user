import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final blogUrl = Uri.parse('https://blog.naver.com/luna_slash');
final homeUrl = Uri.parse('http://www.naver.com');
WebViewController blogUriController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadHtmlString('<h1>hello</h1>')
  ..canGoBack()
  ..canGoForward();

class HomeScreenTest extends StatelessWidget {
  const HomeScreenTest({super.key});
  void onHomePressed() {
    blogUriController.loadHtmlString('<h1>kkkkkk</h1>');
  }

  void onBackPressed() {
    blogUriController.goBack();
  }

  void onForwardPressed() {
    blogUriController.goForward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('세영의 블로그'),
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: onHomePressed,
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: onForwardPressed,
              icon: const Icon(Icons.arrow_forward),
            )
          ],
        ),
        body: WebViewWidget(
          controller: blogUriController,
        ));
  }
}
