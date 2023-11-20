import 'package:benji/app/address/add_new_address.dart';
import 'package:benji/app/address/addresses.dart';
import 'package:benji/app/address/get_location_on_map.dart';
import 'package:benji/app/auth/forgot_password.dart';
import 'package:benji/app/auth/login.dart';
import 'package:benji/app/auth/otp_reset_password.dart';
import 'package:benji/app/auth/reset_password.dart';
import 'package:benji/app/auth/signup.dart';
import 'package:benji/app/home/home.dart';
import 'package:benji/app/onboarding/onboarding_screen.dart';
import 'package:benji/app/orders/order_history.dart';
import 'package:benji/app/packages/choose_rider.dart';
import 'package:benji/app/packages/send_package.dart';
import 'package:benji/app/settings/change_password.dart';
import 'package:benji/app/settings/edit_profile.dart';
import 'package:benji/app/settings/email_verification.dart';
import 'package:benji/app/settings/notification_page.dart';
import 'package:benji/app/settings/settings.dart';
import 'package:benji/app/splash_screens/startup_splash_screen.dart';
import 'package:benji/frontend/join_us/join_us.dart';
import 'package:benji/frontend/main/about.dart';
import 'package:benji/frontend/main/contact_us.dart';
import 'package:benji/frontend/main/faqs.dart';
import 'package:benji/frontend/main/home.dart';
import 'package:benji/frontend/main/privacy_policy.dart';
import 'package:benji/frontend/main/refund_policy.dart';
import 'package:benji/frontend/main/team.dart';
import 'package:benji/frontend/main/term_condition.dart';
import 'package:benji/frontend/store/categories.dart';
import 'package:benji/frontend/store/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetPage myGetPageBuilder(Widget widget) {
  return GetPage(name: "/${widget.runtimeType.toString()}", page: () => widget);
}

class AppRoutes {
  static const startupSplashscreen = "/StartupSplashscreen";

  static final List<GetPage> routes = [
    myGetPageBuilder(const Home()),
    myGetPageBuilder(const HomePage()),
    myGetPageBuilder(const StartupSplashscreen()),
    myGetPageBuilder(const Addresses()),
    myGetPageBuilder(const AddNewAddress()),
    myGetPageBuilder(const GetLocationOnMap()),
    myGetPageBuilder(const Login()),
    myGetPageBuilder(const ForgotPassword()),
    myGetPageBuilder(const OTPResetPassword()),
    myGetPageBuilder(const ResetPassword()),
    myGetPageBuilder(const SignUp()),
    myGetPageBuilder(const OnboardingScreen()),
    myGetPageBuilder(const OrdersHistory()),
    myGetPageBuilder(const ChooseRider()),
    myGetPageBuilder(const SendPackage()),
    myGetPageBuilder(const ChangePassword()),
    myGetPageBuilder(const EditProfile()),
    myGetPageBuilder(const EmailVerification()),
    myGetPageBuilder(const NotificationPage()),
    myGetPageBuilder(const Settings()),
    myGetPageBuilder(const JoinUsPage()),
    myGetPageBuilder(const AboutPage()),
    myGetPageBuilder(const ContactUs()),
    myGetPageBuilder(const FAQsPage()),
    myGetPageBuilder(const PrivacyPolicyPage()),
    myGetPageBuilder(const RefundPolicyPage()),
    myGetPageBuilder(const TeamPage()),
    myGetPageBuilder(const TermsAndConditionPage()),
    myGetPageBuilder(const CategoriesPage()),
    myGetPageBuilder(const SearchPage()),
    // myGetPageBuilder(const AddNewAddress()),
    // GetPage(
    //     name: detailsRoute,
    //     page: () => const HomePage(),
    //     middlewares: [RouteMiddleWare()]),
  ];
}


// here i will check for login first
// class RouteMiddleWare extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     return !AuthService.authenticated
//         ? const RouteSettings(name: AppRoutes.loginRoute)
//         : null;
//   }
// }


