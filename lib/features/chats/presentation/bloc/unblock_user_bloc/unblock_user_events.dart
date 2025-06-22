import 'package:equatable/equatable.dart';

abstract class BlockUserEvents extends Equatable {
  const BlockUserEvents();
}

class BlockUserPressed extends BlockUserEvents {
  final String username;

  const BlockUserPressed({required this.username});

  @override
  List<Object> get props => [username];
}