import 'package:bloc/bloc.dart';
import 'package:chat_app/services/register_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  registerUser({required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      await RegisterService().registerUser(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
            RegisterFailure(errorMessage: 'Invalid email address or password'));
      } else if (e.code == 'email-already-in-use') {
        RegisterFailure(
            errorMessage: 'The account already exists for that email.');
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
