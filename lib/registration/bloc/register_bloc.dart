import 'dart:async';

import 'package:course_portal/data/models/models.dart';
import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterBloc({required this.authenticationRepository})
      : super(const RegisterState()) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<NameChanged>(_onNameChanged);
    on<NameUnfocused>(_onNameUnfocused);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ConfirmPasswordUnfocused>(_onConfirmPasswordUnfocused);
    on<RoleChanged>(_onRoleChanged);
    on<RegisterFormSubmitted>(_onFormSubmitted);
  }
  void _onNameChanged(
    NameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name.valid ? name : Name.pure(event.name),
      status: Formz.validate(
          [name, state.email, state.password, state.confirmPassword]),
    ));
  }

  void _onNameUnfocused(
    NameUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final name = Name.dirty(state.name.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate(
          [name, state.email, state.password, state.confirmPassword]),
    ));
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate(
          [email, state.name, state.password, state.confirmPassword]),
    ));
  }

  void _onEmailUnfocused(
    EmailUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate(
          [email, state.name, state.password, state.confirmPassword]),
    ));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate(
          [password, state.email, state.name, state.confirmPassword]),
    ));
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate(
          [password, state.email, state.name, state.confirmPassword]),
    ));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: event.confirmPassword);
    emit(state.copyWith(
      confirmPassword:
          confirmPassword.valid ? confirmPassword : ConfirmPassword.pure(),
      status: Formz.validate([
        state.name,
        state.email,
        state.password,
        confirmPassword,
      ]),
    ));
  }

  void _onConfirmPasswordUnfocused(
    ConfirmPasswordUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: state.confirmPassword.value);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate(
          [state.name, state.email, state.password, confirmPassword]),
    ));
  }

  void _onRoleChanged(
    RoleChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onFormSubmitted(
    RegisterFormSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // User re = await LoginRepository.register(state.getFormValue);
        User re = await authenticationRepository.register(
            name: state.name.value,
            email: state.email.value,
            password: state.password.value,
            passwordConf: state.confirmPassword.value,
            role: state.role);

        print('_______________________');
        print(re.name);
        print('_______________________');
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
