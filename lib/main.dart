import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_app/login/bloc/login_bloc.dart';
import 'package:location_app/service/login_reg_service.dart';
import 'package:location_app/views/calendar_tab.dart';
import 'package:location_app/views/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'registration/bloc/reg_bloc.dart';
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
    final currentUserExist = FirebaseAuth.instance.currentUser != null;
    void myNavigator(){

    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegBloc(RegService())),
        BlocProvider(create: (context) => LoginBloc(LoginService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: currentUserExist ? CalendarTab() : WelcomeScreen())
    );
  }
}