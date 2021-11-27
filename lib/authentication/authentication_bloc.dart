import 'dart:async';

import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:course_portal/data/repositories/user_repository.dart';
import 'package:course_portal/utilities/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    // required SecureStorage secureStorage
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        //  _secureStorage = secureStorage,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }
  //final SecureStorage _secureStorage;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        //final token = await _secureStorage.getData('access_token');
        //final user = User('name', 'email');
        final id = "1"; //_secureStorage.getData('id') as String;
        final user = await _tryGetUser(int.parse(id));
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    // await _secureStorage.cleanUserData();
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser(int id) async {
    try {
      final user = await _userRepository.getUser(id);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
