import 'package:chat_app/services/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await LoginService().signInUser(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException {
      emit(LoginFailure(errorMessage: 'Invalid email address or password'));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
