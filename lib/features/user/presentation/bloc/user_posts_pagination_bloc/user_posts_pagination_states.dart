import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserPostsPaginationStates extends Equatable {

  @override
  List<Object?> get props => [];
}

class UserPostsPaginationInitial extends UserPostsPaginationStates {}

class UserPostsPaginationLoading extends UserPostsPaginationStates {}

class UserPostsPaginationLoaded extends UserPostsPaginationStates {
  final List<PostEntity> postLists;
  final String username;

  UserPostsPaginationLoaded({required this.postLists,required this.username});


  @override
  List<Object?> get props => [postLists];
}

class UserPostsPaginationError extends UserPostsPaginationStates {
  final String title;
  final String description;
  
  UserPostsPaginationError({required this.title, required this.description});


  @override
  List<Object?> get props => [title,description];
}