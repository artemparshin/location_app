import 'package:flutter/material.dart';
import 'package:location_app/views/reg_view.dart';
import 'login_view.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {return const LoginView();}));
            },
            child: const Text("Login")),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {return const RegView();}));
            },
            child: const Text("Sign up"))
      ]))
    );
  }
}