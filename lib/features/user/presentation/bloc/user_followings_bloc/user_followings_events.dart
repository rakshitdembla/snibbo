import 'package:equatable/equatable.dart';

abstract class UserFollowingsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserFollowings extends UserFollowingsEvents {
  final String username;
  final bool showLoading;

  GetUserFollowings({required this.username,required this.showLoading});

  @override
  List<Object> get props => [username];
}

class LoadMoreUserFollowings extends UserFollowingsEvents {
  final String username;

  LoadMoreUserFollowings({required this.username});
  @override
  List<Object> get props => [username];
}

class SearchFollowing extends UserFollowingsEvents {
  final String username;
  final String userToSearch;

  SearchFollowing({required this.username,required this.userToSearch});

  @override
  List<Object> get props => [username,userToSearch];
}

