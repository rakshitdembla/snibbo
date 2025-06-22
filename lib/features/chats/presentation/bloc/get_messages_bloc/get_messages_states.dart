import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

abstract class MessagesStates extends Equatable {
  const MessagesStates();

  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesStates {}

class MessagesLoading extends MessagesStates {
  final String username;

  const MessagesLoading({required this.username});

  @override
  List<Object?> get props => [username];
}

class MessagesLoaded extends MessagesStates {
  final String username;
  final List<MessageEntity> messages;

  const MessagesLoaded({
    required this.username,
    required this.messages,
  });

  @override
  List<Object?> get props => [username, messages];
}

class MessagesPaginationSuccess extends MessagesStates {
  final String username;
  final List<MessageEntity> messages;

  const MessagesPaginationSuccess({
    required this.username,
    required this.messages,
  });

  @override
  List<Object?> get props => [username, messages];
}

class MessagesError extends MessagesStates {
  final String username;
  final String title;
  final String description;

  const MessagesError({
    required this.username,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [username, title, description];
}

class MessagesPaginationError extends MessagesStates {
  final String username;
  final String title;
  final String description;

  const MessagesPaginationError({
    required this.username,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [username, title, description];
}

class SocketMessagesUpdate extends MessagesStates {
  final List<MessageEntity> messages;

  const SocketMessagesUpdate({required this.messages});
   @override
  List<Object?> get props => [messages];
}
