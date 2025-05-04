abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String title;
  final String description;
  RegisterSuccessState({required this.title,required this.description});
}

class RegisterErrorState extends RegisterStates {
  final String title;
  final String description;
  RegisterErrorState({required this.title,required this.description});
}
