import 'package:equatable/equatable.dart';

abstract class ViewStoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewStory extends ViewStoryEvents {
  final String storyId;

  ViewStory({required this.storyId});

  @override
  List<Object> get props => [storyId];
}

class AllStoriesSeen extends ViewStoryEvents {
  final String username;
  AllStoriesSeen({required this.username});

  @override
  List<Object> get props => [username];
}
