import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserSavedPostsPaginationEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoreSavedPosts extends UserSavedPostsPaginationEvents {
  final String username;

  LoadMoreSavedPosts({required this.username});

  @override
  List<Object?> get props => [username];
}

class InitializeUserSavedPosts extends UserSavedPostsPaginationEvents {
  final String username;
  final List<PostEntity> initialPosts;

  InitializeUserSavedPosts({required this.initialPosts,required this.username});

  @override
  List<Object?> get props => [initialPosts];
}


class ReloadInitialUserSavedPosts extends UserSavedPostsPaginationEvents {
  final String username;
  ReloadInitialUserSavedPosts({required this.username});
  @override
  List<Object?> get props => [username];
}
