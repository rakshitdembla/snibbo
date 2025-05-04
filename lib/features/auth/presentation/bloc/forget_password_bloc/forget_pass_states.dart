abstract class ForgetPassStates {}

class ForgetPassInitialState extends ForgetPassStates {}

class ForgetPassLoadingState extends ForgetPassStates {}

class ForgetPassSuccessState extends ForgetPassStates {
  final String title;
  final String description;
  ForgetPassSuccessState({required this.title,required this.description});
}

class ForgetPassErrorState extends ForgetPassStates {
  final String title;
  final String description;
  ForgetPassErrorState({required this.title,required this.description});
}
