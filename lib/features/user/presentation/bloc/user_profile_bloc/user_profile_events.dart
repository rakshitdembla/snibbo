import 'package:equatable/equatable.dart';

abstract class UserProfileEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserProfile extends UserProfileEvents {
  final String username;

  GetUserProfile({required this.username});

  @override
  List<Object> get props => [username];
}
