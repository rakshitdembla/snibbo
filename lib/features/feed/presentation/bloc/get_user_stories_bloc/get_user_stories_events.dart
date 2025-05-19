import 'package:equatable/equatable.dart';

abstract class UserStoriesEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserStories extends UserStoriesEvents {
  final String username;

  GetUserStories({required this.username});
  @override
  List<Object> get props => [username];
}
