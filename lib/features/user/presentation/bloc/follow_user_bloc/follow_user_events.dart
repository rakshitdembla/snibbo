import 'package:equatable/equatable.dart';

abstract class FollowUserEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowRequested extends FollowUserEvents {
final String username;

  FollowRequested({ required this.username});

  @override
  List<Object> get props => [ username];
}
