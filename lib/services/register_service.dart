import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  Future<void> registerUser(
      {required String email, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
