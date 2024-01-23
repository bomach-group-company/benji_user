import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static CupertinoThemeData? iOSLightTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    applyThemeToAll: true,
  );
  static CupertinoThemeData? iOSDarkTheme = const CupertinoThemeData(
    brightness: Brightness.dark,
    applyThemeToAll: true,
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: GoogleFonts.senTextTheme(),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
