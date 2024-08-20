import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  // Check authentication status when the cubit is initialized
  void checkAuthStatus() {
    final user = authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // Log out the user
  Future<void> logOut() async {
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void clearState() {
    emit(AuthInitial()); // Clear error state before new login attempt
  }
}
