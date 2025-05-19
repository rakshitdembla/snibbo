import 'package:equatable/equatable.dart';

abstract class DeleteStoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteStory extends DeleteStoryEvents {
  final String storyId;

  DeleteStory({required this.storyId});
  @override
  List<Object> get props => [storyId];
}
