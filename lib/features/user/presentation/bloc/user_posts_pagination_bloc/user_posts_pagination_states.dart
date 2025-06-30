import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserPostsPaginationStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserPostsPaginationInitial extends UserPostsPaginationStates {}

class UserPostsPaginationLoaded extends UserPostsPaginationStates {
  final List<PostEntity> postLists;
  final String username;

  UserPostsPaginationLoaded({required this.postLists, required this.username});

  @override
  List<Object?> get props => [postLists];
}

class UserPostsPaginationError extends UserPostsPaginationStates {
  final String title;
  final String description;
  final String username;

  UserPostsPaginationError({
    required this.title,
    required this.description,
    required this.username,
  });

  @override
  List<Object?> get props => [title, description, username];
}

class RefreshUserPostsPagination extends UserPostsPaginationStates {
  final String username;
  RefreshUserPostsPagination({required this.username});
}
