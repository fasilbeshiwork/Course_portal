import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;

  const User(
    this.name,
    this.email,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['email']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
  static const empty = User('-', '-');

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
