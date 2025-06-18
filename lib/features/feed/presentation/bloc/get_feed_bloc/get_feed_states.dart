import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

abstract class GetFeedStates extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFeedInitialState extends GetFeedStates {}

class GetFeedLoadingState extends GetFeedStates {}

class GetFeedErrorState extends GetFeedStates {
  final String title;
  final String description;

  GetFeedErrorState({required this.description, required this.title});
}

class GetFeedSuccessState extends GetFeedStates {
  final String title;
  final String description;
  final List<PostEntity> postsList;
  final List<UserEntity>? storiesList;
  final UserStoriesEntity myStories;

  GetFeedSuccessState({
    required this.title,
    required this.description,
    required this.postsList,
    required this.storiesList,
    required this.myStories,
  });

  @override
  List<Object> get props => [postsList, storiesList ?? [], myStories];
}
