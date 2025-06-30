import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class ExplorePostsStates extends Equatable {
  const ExplorePostsStates();

  @override
  List<Object?> get props => [];
}

class ExplorePostsInitial extends ExplorePostsStates {}

class ExplorePostsLoaded extends ExplorePostsStates {
  final List<PostEntity> posts;

  const ExplorePostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ExplorePaginationSuccess extends ExplorePostsStates {
  final List<PostEntity> posts;

  const ExplorePaginationSuccess({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ExplorePostsError extends ExplorePostsStates {
  final String title;
  final String descrition;

  const ExplorePostsError({required this.title, required this.descrition});

  @override
  List<Object?> get props => [title, descrition];
}

class ExplorePaginationError extends ExplorePostsStates {
  final String title;
  final String descrition;

  const ExplorePaginationError({required this.title, required this.descrition});

  @override
  List<Object?> get props => [title, descrition];
}

class ExplorePostsLoading extends ExplorePostsStates {}


