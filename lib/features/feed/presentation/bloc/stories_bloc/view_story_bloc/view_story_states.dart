abstract class ViewStoryStates {}

class ViewStoryInitialState extends ViewStoryStates {}

class ViewStoryLoadingState extends ViewStoryStates {}

class ViewStoryErrorState extends ViewStoryStates {
  final String title;
  final String description;

  ViewStoryErrorState({required this.description, required this.title});
}

class ViewStorySuccessState extends ViewStoryStates {
  final String title;
  final String description;

  ViewStorySuccessState({
    required this.title,
    required this.description
  });
}
