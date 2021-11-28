import 'dart:async';

import 'package:course_portal/data/dataProviders/authentication_api_provider.dart';
import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/utilities/secure_storage.dart';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final AuthenticationApiProvider _authenticationApiProvider =
      AuthenticationApiProvider();
  //AuthenticationApiProvider(secureStorage: SecureStorage());

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    print('trying to log in');

    final user =
        await _authenticationApiProvider.logIn(email, password, http.Client());
    _controller.add(AuthenticationStatus.authenticated);
    /* await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );*/
    print('logged in');
    return user;
  }

  Future<User> register(
      {required String name,
      required String email,
      required String password,
      required String passwordConf,
      required String role}) async {
    print('trying to register');

    final response = await _authenticationApiProvider.register(
        name: name,
        email: email,
        password: password,
        passwordConf: passwordConf,
        role: role,
        client: http.Client());
    print('registered');
    _controller.add(AuthenticationStatus.authenticated);
    return response;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
