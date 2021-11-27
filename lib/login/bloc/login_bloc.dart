import 'package:course_portal/data/models/email.dart';
import 'package:course_portal/data/models/models.dart';
import 'package:course_portal/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEmailUnfocused>(_onEmailUnfocused);
    on<LoginPasswordUnfocused>(_onPasswordUnfocused);
    on<LoginFormSubmitted>(_onFormSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;
  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onEmailUnfocused(
    LoginEmailUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onPasswordUnfocused(
    LoginPasswordUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onFormSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        print('CCCCCCCCCCCCCCCCCCC');
        await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        print('EEE' + e.toString());
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
