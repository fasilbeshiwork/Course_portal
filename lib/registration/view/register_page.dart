import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:course_portal/registration/bloc/register_bloc.dart';
import 'package:course_portal/registration/view/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (item) => handleClick(context, item),
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context) {
                return {'Login', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (blocContext) => RegisterBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>()),
          //  RegisterBloc(LoginRepository: context.read<LoginRepository>()),
          child: const RegisterForm(),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  void handleClick(BuildContext context, String value) {
    switch (value) {
      case 'Login':
        Navigator.of(context).pop();
        //Navigator.pop(context);

        break;
      case 'Settings':
        break;
    }
  }
}
