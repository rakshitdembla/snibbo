import 'package:equatable/equatable.dart';

abstract class UnblockUserStates extends Equatable {
  const UnblockUserStates();

  @override
  List<Object?> get props => [];
}

class UnblockUserInitial extends UnblockUserStates {}

class UnblockUserLoading extends UnblockUserStates {}

class UnblockUserSuccess extends UnblockUserStates {}

class UnblockUserError extends UnblockUserStates {
  final String title;
  final String description;

  const UnblockUserError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}