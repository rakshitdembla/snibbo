import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends LoginEvents {
  final String email;
  final String password;

  Login({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
