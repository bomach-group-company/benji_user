import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchDownloadLinkAndroid() async {
  final url = Uri.parse(
      'https://drive.google.com/file/d/1k8d29KTyISAVru_8mk_zaILPHyhUN7au/view?usp=sharing');
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<void> launchDownloadLinkIOS() async {
  final url = Uri.parse('https://bomachgroup.com/');
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<void> launchDownload(String openUrl) async {
  final url = Uri.parse(openUrl);
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}

void launchPhoneDialer(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    ApiProcessorController.errorSnack("Rider number not available");
    // throw 'Could not launch $phoneUri';
  }
}
