import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserSavedPostsPaginationStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSavedPostsPaginationInitial extends UserSavedPostsPaginationStates {}

class UserSavedPostsPaginationLoaded extends UserSavedPostsPaginationStates {
  final String username;
  final List<PostEntity> postLists;

  UserSavedPostsPaginationLoaded({
    required this.postLists,
    required this.username,
  });

  @override
  List<Object?> get props => [postLists];
}

class UserSavedPostsPaginationError extends UserSavedPostsPaginationStates {
  final String title;
  final String description;
  final String username;

  UserSavedPostsPaginationError({
    required this.title,
    required this.description,
    required this.username
  });

  @override
  List<Object?> get props => [title, description,username];
}
class RefreshUserSavedPostsPagination extends UserSavedPostsPaginationStates {
  final String username;
  RefreshUserSavedPostsPagination({required this.username});
}
