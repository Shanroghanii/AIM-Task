import 'package:equatable/equatable.dart';

// Define your states
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class LoginInvalidFields extends LoginState {
  final String? emailError;
  final String? passwordError;
  const LoginInvalidFields(this.emailError, this.passwordError);
  @override
  List<Object?> get props => [emailError, passwordError];
}
