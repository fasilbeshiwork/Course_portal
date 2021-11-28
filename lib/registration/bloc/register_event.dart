part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NameUnfocused extends RegisterEvent {}

class EmailUnfocused extends RegisterEvent {}

class PasswordUnfocused extends RegisterEvent {}

class ConfirmPasswordUnfocused extends RegisterEvent {}

class RegisterFormSubmitted extends RegisterEvent {}

class NameChanged extends RegisterEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegisterEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });
  final String confirmPassword;
  @override
  List<Object> get props => [confirmPassword];
}

class RoleChanged extends RegisterEvent {
  const RoleChanged({
    required this.role,
  });
  final String role;
  @override
  List<Object> get props => [role];
}
