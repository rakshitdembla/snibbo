import 'package:equatable/equatable.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object?> get props => [];
}

class SearchUserInitial extends SearchUserState {}

class SearchUserLoading extends SearchUserState {}

class SearchUserFound extends SearchUserState {
  final List<UserEntity> user;

  const SearchUserFound(this.user);

  @override
  List<Object?> get props => [user];
}

class SearchUserNotFound extends SearchUserState {}

class SearchUserEmptyState extends SearchUserState{
  final String title;
  final String description;

 const SearchUserEmptyState({required this.description,required this.title});

   @override
  List<Object?> get props => [title,description];


}
