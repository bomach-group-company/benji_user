import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/payment/monnify_payment_sdk.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();

  // await dotenv.load();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Benji",
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      //This is the home route
      home: PayWithMonnify(),
    );
  }
}
