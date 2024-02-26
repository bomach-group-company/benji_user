import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

// const String baseURL = 'https://resource.bgbot.app/api/v1';
// const String baseImage = "https://resource.bgbot.app";
// const String baseURL = 'https://benji-app.onrender.com/api/v1';

const String notAvailable = 'N/A';
const int maxImageSize = 5 * 1024 * 1024; // 5 MB

Future<bool> checkXFileSize(XFile image) async {
  int imgLen = await image.length();
  return imgLen > maxImageSize;
}

Future<bool> checkFileSize(File image) async {
  int imgLen = await image.length();
  return imgLen > maxImageSize;
}

void consoleLog(String val) {
  for (var i = 0; i < val.length; i += 1024) {
    debugPrint(val.substring(i, i + 1024 < val.length ? i + 1024 : val.length));
  }
}

void consoleLogToFile(String val) {
  File('log.txt').writeAsStringSync(val);
}
