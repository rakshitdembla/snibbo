import 'package:equatable/equatable.dart';

abstract class UserFollowersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserFollowers extends UserFollowersEvents {
  final String username;
  final bool showLoading;

  GetUserFollowers({required this.username,required this.showLoading});

    @override
  List<Object> get props => [username];


}

class LoadMoreUserFollowers extends UserFollowersEvents {
  final String username;

  LoadMoreUserFollowers({required this.username});

  @override
  List<Object> get props => [username];
}

class SearchFollower extends UserFollowersEvents {
  final String username;
  final String userToSearch;

  SearchFollower({required this.username,required this.userToSearch});

  @override
  List<Object> get props => [username,userToSearch];
}
