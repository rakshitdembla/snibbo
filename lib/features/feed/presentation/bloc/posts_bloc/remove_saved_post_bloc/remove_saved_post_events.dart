import 'package:equatable/equatable.dart';

abstract class RemoveSavedPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RemoveSavedPostRequested extends RemoveSavedPostEvent {
  final String postId;

  RemoveSavedPostRequested({required this.postId});

  @override
  List<Object> get props => [postId];
}
