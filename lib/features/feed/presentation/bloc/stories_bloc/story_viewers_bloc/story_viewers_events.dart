import 'package:equatable/equatable.dart';

abstract class StoryViewersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetStoryViewers extends StoryViewersEvents {
  final String storyId;

  GetStoryViewers({required this.storyId});
  @override
  List<Object> get props => [storyId];
}
