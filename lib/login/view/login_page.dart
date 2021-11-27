import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:course_portal/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (bloContext) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>()),
          //LoginBloc(LoginRepository: context.read<LoginRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
