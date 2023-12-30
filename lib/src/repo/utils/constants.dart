import 'package:flutter/foundation.dart';
import 'dart:io';

const String baseURL = 'https://resource.bgbot.app/api/v1';
const String baseImage = "https://resource.bgbot.app";
// const String baseURL = 'https://benji-app.onrender.com/api/v1';


const String notAvailable = 'N/A';

void consoleLog(String val) {
  for (var i = 0; i < val.length; i += 1024) {
    debugPrint(val.substring(i, i + 1024 < val.length ? i + 1024 : val.length));
  }
}

void consoleLogToFile(String val) {
  File('log.txt').writeAsStringSync(val);
}
