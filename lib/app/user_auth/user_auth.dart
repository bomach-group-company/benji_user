import 'package:benji_user/app/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/repo/models/user_model.dart';
import '../../src/repo/utils/helpers.dart';
import '../home/home.dart';

class UserSnapshot extends StatelessWidget {
  static String routeName = "User Snapshot";
  const UserSnapshot({super.key});

  Future<User?> rememberUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    if (rememberMe == true) {
      print("Remember me is $rememberMe");
      return getUser();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: Stream<User?>.fromFuture(rememberUser()),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const Home();
            } else {
              return const OnboardingScreen();
            }
          },
        ),
      );
}
