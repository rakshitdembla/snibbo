import 'package:equatable/equatable.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();

    @override
  List<Object> get props => [];
}

class SearchUserByUsername extends SearchUserEvent {
  final String username;

  const SearchUserByUsername({required this.username});

  @override
  List<Object> get props => [username];
}

class ResetSearch extends SearchUserEvent{}