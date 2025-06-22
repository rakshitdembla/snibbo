import 'package:equatable/equatable.dart';

abstract class BlockUserStates extends Equatable {
  const BlockUserStates();

  @override
  List<Object?> get props => [];
}

class BlockUserInitial extends BlockUserStates {}

class BlockUserLoading extends BlockUserStates {}

class BlockUserSuccess extends BlockUserStates {}

class BlockUserError extends BlockUserStates {
  final String title;
  final String description;

  const BlockUserError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}