import 'package:equatable/equatable.dart';

abstract class UnfollowUserEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class UnfollowRequested extends UnfollowUserEvents {
  final String username;

  UnfollowRequested({required this.username});

  @override
  List<Object> get props => [username];
}
