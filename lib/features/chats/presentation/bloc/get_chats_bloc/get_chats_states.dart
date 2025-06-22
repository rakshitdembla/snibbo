import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

abstract class ChatsListStates extends Equatable {
  const ChatsListStates();

  @override
  List<Object?> get props => [];
}

class ChatsListInitial extends ChatsListStates {}

class ChatsListLoading extends ChatsListStates {}

class ChatsListLoaded extends ChatsListStates {
  final List<ChatListEntity> chats;

  const ChatsListLoaded({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class ChatsListPaginationSuccess extends ChatsListStates {
  final List<ChatListEntity> chats;

  const ChatsListPaginationSuccess({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class ChatsListError extends ChatsListStates {
  final String title;
  final String description;

  const ChatsListError({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class ChatsListPaginationError extends ChatsListStates {
  final String title;
  final String description;

  const ChatsListPaginationError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class SocketUpdateChatList extends ChatsListStates {
  final List<ChatListEntity>? chats;
  final MessageEntity? message;

  const SocketUpdateChatList({this.chats, this.message});

  @override
  List<Object?> get props => [chats, message];
}
