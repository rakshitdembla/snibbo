abstract class CreateStoryStates {}

class CreateStoryInitialState extends CreateStoryStates {}

class CreateStoryLoadingState extends CreateStoryStates {}

class CreateStorySucessState extends CreateStoryStates {
  final String title;
  final String description;

  CreateStorySucessState({required this.description, required this.title});
}

class CreateStoryErrorState extends CreateStoryStates {
  final String title;
  final String description;

  CreateStoryErrorState({required this.description, required this.title});
}
