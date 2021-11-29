import 'package:bloc_test/bloc_test.dart';
import 'package:course_portal/data/models/models.dart';
import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:course_portal/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';
import 'package:formz/formz.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  User user = User('gadisa', 'g@gmail.com');
  MockAuthenticationRepository authenticationRepository =
      MockAuthenticationRepository();
  LoginBloc loginBloc =
      LoginBloc(authenticationRepository: authenticationRepository);
  final email = Email.dirty('g@gmail.com');
  final password = Password.dirty('pw112');
  group('Bloc test', () {
    test('initial state is correct', () {
      expect(loginBloc.state, const LoginState());
    });
    blocTest<LoginBloc, LoginState>("Email Changed",
        build: () {
          when(authenticationRepository.logIn(
                  email: 'g@gmail.com', password: 'pw123'))
              .thenAnswer(
            (realInvocation) => Future.value(user),
          );
          return LoginBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(const LoginEmailChanged('g@gmail.com')),
        expect: () => [
              LoginState().copyWith(
                email: email.valid ? email : Email.pure('g@gmail.com'),
                status: Formz.validate([email, Password.dirty('')]),
              )
            ]);
    blocTest<LoginBloc, LoginState>("Email Unfocused",
        build: () {
          when(authenticationRepository.logIn(
                  email: 'g@gmail.com', password: 'pw123'))
              .thenAnswer(
            (realInvocation) => Future.value(user),
          );
          return LoginBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(const LoginEmailChanged('g@gmail.com')),
        expect: () => [
              LoginState().copyWith(
                email: email.valid ? email : Email.pure('g@gmail.com'),
                status: Formz.validate([email, Password.dirty('')]),
              )
            ]);

    blocTest<LoginBloc, LoginState>("Password Changed",
        build: () {
          when(authenticationRepository.logIn(
                  email: 'g@gmail.com', password: 'pw123'))
              .thenAnswer(
            (realInvocation) => Future.value(user),
          );
          return LoginBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(const LoginPasswordChanged('pw112')),
        expect: () => [
              LoginState().copyWith(
                password: password,
                status: Formz.validate([password, Email.dirty('')]),
              )
            ]);
    blocTest<LoginBloc, LoginState>("Password Unfocused",
        build: () {
          when(authenticationRepository.logIn(
                  email: 'g@gmail.com', password: 'pw123'))
              .thenAnswer(
            (realInvocation) => Future.value(user),
          );
          return LoginBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(const LoginPasswordChanged('pw112')),
        expect: () => [
              LoginState().copyWith(
                password: password,
                status: Formz.validate([password, Email.dirty('')]),
              )
            ]);
    loginBloc.state.copyWith(
        email: Email.dirty('g@gmail.com'),
        password: Password.dirty('pw123'),
        status: Formz.validate([email, password]));

    blocTest<LoginBloc, LoginState>("Login Form Submited",
        build: () {
          when(authenticationRepository.logIn(
                  email: 'g@gmail.com', password: 'pw123'))
              .thenAnswer(
            (realInvocation) => Future.value(user),
          );
          return loginBloc; //LoginBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(LoginFormSubmitted()),
        expect: () => []);
    //[LoginState().copyWith(status: FormzStatus.submissionInProgress)]);
  });
}
