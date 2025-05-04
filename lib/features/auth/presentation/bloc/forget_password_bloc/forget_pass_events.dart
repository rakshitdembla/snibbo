import 'package:equatable/equatable.dart';

abstract class ForgetPassEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPassword extends ForgetPassEvents {
  final String email;

  ForgetPassword({required this.email,});

  @override
  List<Object> get props => [email];
}