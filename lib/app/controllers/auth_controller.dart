import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uuid; // cek user apakah login?
  late FirebaseAuth auth;

  Future<Map<String, Object>> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return {
        "error": false,
        "message": "berhasil login",
      };
    } on FirebaseException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "gagal login",
      };
    }
  }

  Future<Map<String, Object>> logout() async {
    try {
      await auth.signOut();
      return {
        "error": false,
        "message": "berhasil logout",
      };
    } on FirebaseException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "gagal logout",
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      uuid = event?.uid;
    });
    super.onInit();
  }
}
