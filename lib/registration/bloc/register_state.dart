part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.role = 'student',
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String role;
  final FormzStatus status;

  RegisterState copyWith({
    Name? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    String? role,
    FormzStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [name, email, password, confirmPassword, role, status];

  List<String> get getFormValue =>
      [name.value, email.value, password.value, role];
}
