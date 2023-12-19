import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  Future<void> signInUser(
      {required String email, required String password}) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
