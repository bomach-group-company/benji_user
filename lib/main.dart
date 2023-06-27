import 'package:alpha_logistics/app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/routes.dart';
// import 'splash screens/startup splash screen.dart';
import 'theme/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Benji",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(
            kDarkGreyColor,
          ),
          radius: const Radius.circular(
            6,
          ),
        ),
        textTheme: GoogleFonts.senTextTheme(
          // Update the textTheme property
          Theme.of(context).textTheme, // Use the default theme
        ),
      ),
      // initialRoute: StartupSplashscreen.routeName,
      home: Home(),
      routes: routes,
    );
  }
} 
