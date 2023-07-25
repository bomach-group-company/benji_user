import 'package:benji_user/app/home/home.dart';
import 'package:benji_user/app/screens/onboarding%20screen.dart';
import 'package:benji_user/src/services/repos/signup_email_password_failure.dart';
import 'package:benji_user/src/splash%20screens/startup%20splash%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const StartupSplashscreen())
        : Get.offAll(() => const Home());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const OnboardingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      print("FIRBASE AUTH EXCEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
