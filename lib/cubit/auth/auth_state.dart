import 'package:equatable/equatable.dart';

// Define your states
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}

