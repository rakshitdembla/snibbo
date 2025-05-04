import 'package:equatable/equatable.dart';

abstract class RegisterEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class Register extends RegisterEvents {
  final String name;
  final String username;
  final String email;
  final String password;

  Register({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
  });

  @override
  List<Object> get props => [email, password,name,username];
}
