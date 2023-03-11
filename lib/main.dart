import 'package:flutter/material.dart';
import 'package:location_app/Login/bloc/login_bloc.dart';
import 'package:location_app/service/login_reg_service.dart';
import 'package:location_app/views/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Registration/bloc/reg_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegBloc(RegService())),
        BlocProvider(create: (context) => LoginBloc(LoginService())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen())
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return RepositoryProvider(
  //     create: (context) => RegUser(),
  //     child: BlocProvider(
  //       create: (context) => RegBloc(regUser: RepositoryProvider.of<RegUser>(context)),
  //       child: MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           home: WelcomeScreen()
  //       ),
  //     ),
  //   );
  // }
}