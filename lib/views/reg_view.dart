import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/registration/bloc/reg_bloc.dart';
import 'package:location_app/registration/bloc/reg_event.dart';
import 'package:location_app/views/welcome_screen.dart';
import '../registration/bloc/reg_state.dart';

class RegView extends StatefulWidget {
  const RegView({super.key});

  @override
  State<RegView> createState() => _RegViewState();
}

class _RegViewState extends State<RegView> {
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
            BlocBuilder<RegBloc, RegState>(
              builder: (context, state) {
                return (state is RegFailure
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
    return BlocConsumer<RegBloc, RegState>(
      listener: (context, state) {
        state is RegSuccess
        ? Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
            return const WelcomeScreen();
          }))
        : null;
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is RegLoading
            ? null
            : () {
              context.read<RegBloc>().add(RegistrationRequested(
                usernameFieldController.text,
                passwordFieldController.text));
              },
          child: const Text("Register new user"));
      },
    );
  }
}
