import 'package:auth_task/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/login/login_state.dart';
import '../widgets/responsive_sizebox.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen and viewInsets
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    // Determine the height based on whether the keyboard is open
    final sizedBoxHeight = bottomInset > 0
        ? screenHeight * 0.08 // When keyboard is open, 10% of screen height
        : screenHeight * 0.12; // When keyboard is closed, 30% of screen height
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            _showErrorSnackBar(context, state.error);
          } else if (state is LoginInvalidFields) {
            _showErrorDialog(context, state.emailError, state.passwordError);
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF180F0F),
                    primaryColor,
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(context),
                    ResponsiveSizedBox(
                      sizedBoxHeight: sizedBoxHeight,
                    ),
                    _buildEmailField(),
                    const SizedBox(height: 16),
                    _buildPasswordField(),
                    const SizedBox(height: 24),
                    _buildLoginButton(context),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      "Log in!",
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 36,
            color: Colors.pink,
          ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.alternate_email),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          final email = _emailController.text.trim();
          final password = _passwordController.text.trim();
          context.read<LoginCubit>().logIn(email, password);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: Text(
            'Login',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Widget _buildSignUpButton(BuildContext context) {
  //   return TextButton(
  //     onPressed: () {
  //       final email = _emailController.text.trim();
  //       final password = _passwordController.text.trim();
  //       context.read<LoginCubit>().signUp(email, password);
  //     },
  //     child: const Text('Sign Up'),
  //   );
  // }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorDialog(
      BuildContext context, String? emailError, String? passwordError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Error'),
          content: const Text("Email/Password are incorrect"),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<LoginCubit>().clearError();
              },
            ),
          ],
        );
      },
    );
  }
}
