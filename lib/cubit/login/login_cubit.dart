import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import '../auth/auth_state.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginInitial());

  Future<void> logIn(String email, String password) async {
    if (_validateFields(email, password)) {
      emit(LoginLoading());
      try {
        final user =
            await authRepository.signInWithEmailAndPassword(email, password);
        if (user != null) {
          emit(LoginSuccess());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          try {
            final newUser = await authRepository.signUpWithEmailAndPassword(
                email, password);
            if (newUser != null) {
              emit(LoginSuccess());
            } else {
              emit(const LoginFailure('Auto sign-up failed'));
            }
          } catch (signUpError) {
            emit(LoginFailure(signUpError.toString()));
          }
        } else {
          emit(const LoginFailure('Invalid password'));
        }
      }
    } else {
      emit(const LoginInvalidFields('Invalid email', 'Invalid password'));
    }
  }

  void clearError() {
    emit(LoginInitial()); // Clear error state before new login attempt
  }

  bool _validateFields(String email, String password) {
    // Simple validation (can be more complex)
    return email.isNotEmpty && password.isNotEmpty;
  }
}
