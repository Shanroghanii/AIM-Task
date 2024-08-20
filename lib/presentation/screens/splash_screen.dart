import 'package:auth_task/data/repositories/auth_repository.dart';
import 'package:auth_task/presentation/screens/home_screen.dart';
import 'package:auth_task/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/auth/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth firebaseAuth =
      FirebaseAuth.instance; // Initialize FirebaseAuth instance
  late final AuthRepository authRepository; // Pass the FirebaseAuth instance

  @override
  void initState() {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    authRepository = AuthRepository(firebaseAuth);
    super.initState();

    Future.delayed(const Duration(microseconds: 1), () {
      authCubit.checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Handle authenticated state (e.g., navigate to Home Screen)
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthUnauthenticated) {
            // Handle unauthenticated state (e.g., navigate to Login Screen)
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          // Display a loading indicator while checking authentication
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
