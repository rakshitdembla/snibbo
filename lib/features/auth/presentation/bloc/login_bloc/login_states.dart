abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String title;
  final String description;
  LoginSuccessState({required this.title,required this.description});
}

class LoginErrorState extends LoginStates {
  final String title;
  final String description;
  LoginErrorState({required this.title,required this.description});
}
