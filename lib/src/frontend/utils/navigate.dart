import 'package:benji/app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> toLoginPage() async {
  Get.to(
    () => const Login(),
    routeName: 'Login',
    duration: const Duration(milliseconds: 300),
    fullscreenDialog: true,
    curve: Curves.easeIn,
    preventDuplicates: true,
    popGesture: true,
    transition: Transition.rightToLeft,
  );
}
