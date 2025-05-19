abstract class DeleteStoryStates {}

class DeleteStoryInitialState extends DeleteStoryStates {}

class DeleteStoryLoadingState extends DeleteStoryStates {}

class DeleteStoryErrorState extends DeleteStoryStates {
  final String title;
  final String description;

  DeleteStoryErrorState({required this.description, required this.title});
}

class DeleteStorySuccessState extends DeleteStoryStates {
  final String title;
  final String description;

  DeleteStorySuccessState({required this.title, required this.description});
}
