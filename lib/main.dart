import 'package:auth_task/presentation/screens/home_screen.dart';
import 'package:auth_task/presentation/screens/login_screen.dart';
import 'package:auth_task/presentation/screens/splash_screen.dart';
import 'package:auth_task/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;  // Initialize FirebaseAuth instance
  final AuthRepository authRepository = AuthRepository(firebaseAuth);  // Pass the FirebaseAuth instance

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authRepository),
        ),
      ],
      child: MaterialApp(
        theme: AppThemes.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
