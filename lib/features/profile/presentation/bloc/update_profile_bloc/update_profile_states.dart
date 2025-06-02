import 'package:equatable/equatable.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String title;
  final String description;

  const UpdateProfileSuccess({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class UpdateProfileError extends UpdateProfileState {
  final String title;
  final String description;

  const UpdateProfileError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
