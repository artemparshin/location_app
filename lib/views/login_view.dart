import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/Login/bloc/login_event.dart';
import 'package:location_app/views/calendar_tab.dart';
import '../Login/bloc/login_bloc.dart';
import '../Login/bloc/login_state.dart';
import '../service/login_reg_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            _passwordField(),
            _loginButton(context),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return (
                  state is LoginFailure
                  ? const Text('Something went wrong')
                  : const SizedBox.shrink()
                );
              },
            ),
          ]
        )
      )
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: usernameFieldController,
      decoration: const InputDecoration(hintText: "Username"),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: passwordFieldController,
      //obscureText: true,
      decoration: const InputDecoration(hintText: "Password"),
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        state is LoginSuccess
        ? Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
            return const CalendarTab();
          }))
         : null;
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            state is LoginLoading ? null : () {
              context.read<LoginBloc>().add(LoginRequested(
                usernameFieldController.text, passwordFieldController.text));
            };
          },
          child: const Text("Login")
        );
      }
    );
  }
}
