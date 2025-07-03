import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/sound_effects_utils.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';
import 'package:snibbo_app/features/chats/domain/use_cases/get_messages_usecase.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_states.dart';
import 'package:snibbo_app/service_locator.dart';

class MessagesBloc extends Bloc<MessagesEvents, MessagesStates> {
  int page = 1;
  List<MessageEntity> allMessages = [];
  bool hasMore = true;
  bool isLoading = false;
  String messagesChatId = "";

  MessagesBloc() : super(MessagesInitial()) {
    on<GetMessages>((event, emit) async {
      emit(MessagesLoading(username: event.username));

      page = 1;
      allMessages = [];
      hasMore = true;
      isLoading = false;
      messagesChatId = "";

      final tokenId = await ServicesUtils.getTokenId();

      final (
        bool success,
        String? chatId,
        List<MessageEntity>? messages,
        String? message,
      ) = await sl<GetMessagesUseCase>().call(
        tokenId: tokenId!,
        username: event.username,
        page: page,
        limit: 30,
      );

      if (chatId != null && chatId.isNotEmpty && success && messages != null) {
        allMessages.addAll(messages);
        hasMore = messages.length == 30;
        page = 2;
        messagesChatId = chatId;

        emit(MessagesLoaded(username: event.username, messages: messages));
        return;
      }

      emit(
        MessagesError(
          username: event.username,
          title: "Failed to fetch messages",
          description: message.toString(),
        ),
      );
    });

    on<LoadMoreMessages>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final tokenId = await ServicesUtils.getTokenId();

      final (
        bool success,
        String? chatId,
        List<MessageEntity>? messages,
        String? message,
      ) = await sl<GetMessagesUseCase>().call(
        tokenId: tokenId!,
        username: event.username,
        page: page,
        limit: 30,
      );

      if (chatId != null && chatId.isNotEmpty && success && messages != null) {
        allMessages.addAll(messages);
        hasMore = messages.length == 30;
        messagesChatId = chatId;
        page++;

        isLoading = false;
        emit(
          MessagesPaginationSuccess(
            username: event.username,
            messages: messages,
          ),
        );
        return;
      }

      emit(
        MessagesPaginationError(
          username: event.username,
          title: "Failed to load more messages",
          description: message.toString(),
        ),
      );
      isLoading = false;
    });

    on<SocketAllMessageSeen>((event, emit) {
      debugPrint("Got All messages seen event!");
      for (var message in allMessages) {
        if (message.chat == event.chatId) {
          message.isSeenByOther = true;
        }
      }
      emit(SocketMessagesUpdate(messages: List.from(allMessages)));
    });

    on<SocketNewMessage>((event, emit) async{
      debugPrint("Got New Message Add Event!");
      if (event.message.chat.toString() == messagesChatId) {
        allMessages.insert(0, event.message);
        emit(SocketMessagesUpdate(messages: [event.message]));
        SoundEffectsUtils.receivedMessage();
      }
    });

    on<SendNewMessage>((event, emit) async{
      debugPrint("Sent New Message Event!");
      if (event.message.chat.toString() == messagesChatId) {
        allMessages.insert(0, event.message);
        emit(SocketMessagesUpdate(messages: [event.message]));
        SoundEffectsUtils.sentMessage();
      }
    });
  }
}
