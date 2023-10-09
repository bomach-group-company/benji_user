import 'package:benji/app/auth/login.dart';
import 'package:benji/app/home/home.dart';
import 'package:benji/app/splash_screens/startup_splash_screen.dart';
import 'package:benji/frontend/main/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const login = "/Login";
  static const home = "/Home";
  static const homePage = "/HomePage";
  static const startupSplashscreen = "/StartupSplashscreen";

  static final List<GetPage> routes = [
    GetPage(name: login, page: () => const Login()),
    GetPage(name: home, page: () => const Home()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(name: startupSplashscreen, page: () => const StartupSplashscreen()),
    // GetPage(
    //     name: detailsRoute,
    //     page: () => const HomePage(),
    //     middlewares: [RouteMiddleWare()]),
  ];
// static final GoRouter routes = GoRouter(routes: <GoRoute>[
//   GoRoute(
//     path: loginRoute,
//     builder: (BuildContext context, state) => const LoginView(),
//   ),
//   GoRoute(
//     path: DashboardRoute,
//     builder: (_, state) => const DashboardView(),
//     redirect: (context, state) => _redirect(context),
//   ),
//   GoRoute(
//     path: DetailsRoute,
//     builder: (_, state) => const DetailsView(),
//     redirect: (context, state) => _redirect(context),
//   ),
// ]);

// static String? _redirect(BuildContext context) {
//   return AuthService.authenticated ? null : context.namedLocation("/");
// }
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


