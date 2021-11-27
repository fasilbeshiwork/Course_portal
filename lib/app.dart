import 'package:course_portal/courseList/view/course_list.dart';
import 'package:course_portal/login/view/login_form.dart';
import 'package:course_portal/registration/view/register_page.dart';
import 'package:course_portal/utilities/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication_bloc.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/repositories/user_repository.dart';

import 'login/view/login_page.dart';
import 'package:course_portal/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
          //secureStorage: SecureStorage()
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Portal',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  //HomePage.route(),
                  CourseListPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  //CourseListPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settting) {
        switch (settting.name) {
          case 'login':
            return MaterialPageRoute(builder: (context) {
              return const LoginForm();
            });
          case 'register':
            return MaterialPageRoute(builder: (context) {
              return const RegisterPage();
            });
          default:
            return MaterialPageRoute(builder: (context) {
              return const SplashPage();
            });
        }
      },
    );
  }
}
