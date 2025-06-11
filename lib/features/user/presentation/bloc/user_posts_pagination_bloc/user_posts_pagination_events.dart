import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserPostsPaginationEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoreUserPosts extends UserPostsPaginationEvents {
  final String username;

  LoadMoreUserPosts({required this.username});

  @override
  List<Object?> get props => [username];
}

class InitializeUserPosts extends UserPostsPaginationEvents {
  final List<PostEntity> initialPosts;
  final String username;

  InitializeUserPosts({required this.initialPosts, required this.username});

  @override
  List<Object?> get props => [initialPosts];
}

class ReloadInitialUserPosts extends UserPostsPaginationEvents {
  final String username;
  ReloadInitialUserPosts({required this.username});
  @override
  List<Object?> get props => [username];
}

