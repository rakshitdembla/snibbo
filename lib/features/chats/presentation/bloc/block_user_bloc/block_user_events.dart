import 'package:equatable/equatable.dart';

abstract class UnblockUserEvents extends Equatable {
  const UnblockUserEvents();
}

class UnblockUserPressed extends UnblockUserEvents {
  final String username;

  const UnblockUserPressed({required this.username});

  @override
  List<Object> get props => [username];
}