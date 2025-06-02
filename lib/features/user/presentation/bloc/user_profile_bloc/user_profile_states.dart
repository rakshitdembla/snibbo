import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

abstract class UserProfileStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileStates {}

class UserProfileLoading extends UserProfileStates {}

class UserProfileSuccess extends UserProfileStates {
  final bool isMyProfile;
  final ProfileEntity profileEntity;

  UserProfileSuccess({required this.isMyProfile, required this.profileEntity});

  @override
  List<Object> get props => [profileEntity];
}

class UserProfileError extends UserProfileStates {
  final String title;
  final String description;

  UserProfileError({required this.description, required this.title});
}

