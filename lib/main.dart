import 'package:flutter/material.dart';
import 'package:location_app/views/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Auth/auth_repository.dart';
import 'Auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: WelcomeScreen()
        ),
      ),
    );
  }
}