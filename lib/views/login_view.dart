import 'dart:js';

import 'package:flutter/material.dart';
import 'package:location_app/views/calendar_tab.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(context)
    );
  }
}

Widget _loginForm(BuildContext context){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _usernameField(),
        _passwordField(),
        _loginButton(context)
      ]
    )
  );
}

Widget _usernameField(){
  return TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
      hintText: "Username"
    ),
  );
}

Widget _passwordField(){
  return TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
      hintText: "Password"
    ),
  );
}

Widget _loginButton(BuildContext context){
  return ElevatedButton(
    onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {return const CalendarTab();}));
    },
    child: const Text("Login")
  );
}