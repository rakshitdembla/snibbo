import 'package:equatable/equatable.dart';

abstract class UserFollowingsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserFollowings extends UserFollowingsEvents {
  final String username;

  GetUserFollowings({required this.username});

  @override
  List<Object> get props => [username];
}

class LoadMoreUserFollowings extends UserFollowingsEvents {
  final String username;

  LoadMoreUserFollowings({required this.username});
  @override
  List<Object> get props => [username];
}
