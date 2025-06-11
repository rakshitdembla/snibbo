import 'package:equatable/equatable.dart';

abstract class UserFollowersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserFollowers extends UserFollowersEvents {
  final String username;

  GetUserFollowers({required this.username});

    @override
  List<Object> get props => [username];


}

class LoadMoreUserFollowers extends UserFollowersEvents {
  final String username;

  LoadMoreUserFollowers({required this.username});

  @override
  List<Object> get props => [username];
}
