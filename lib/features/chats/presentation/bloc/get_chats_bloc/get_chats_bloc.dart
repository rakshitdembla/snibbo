import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/network/web_sockets/web_sockets_services.dart';
import 'package:snibbo_app/core/utils/sound_effects_utils.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/use_cases/get_chats_usecase.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_states.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';

class ChatsListBloc extends Bloc<ChatsListEvents, ChatsListStates> {
  int page = 1;
  List<ChatListEntity> allChats = [];
  bool hasMore = true;
  bool isLoading = false;

  ChatsListBloc() : super(ChatsListInitial()) {
    on<GetChatsList>((event, emit) async {
      emit(ChatsListLoading());

      // Reset all
      page = 1;
      allChats = [];
      hasMore = true;
      isLoading = false;

      final tokenId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<ChatListEntity>? chats,
        String? message,
      ) = await sl<GetChatsUseCase>().call(
        tokenId: tokenId!,
        page: page,
        limit: 12,
      );

      if (success && chats != null) {
        allChats.addAll(chats);
        StoryViewsManager.clearStoriesByChats(chats: chats);
        hasMore = chats.length == 12;
        page = 2;

        emit(ChatsListLoaded(chats: chats));
        sl<WebSocketsServices>().emitjoinChats(
          roomIds: chats.map((chat) => chat.id).toList(),
        );
        return;
      }

      emit(
        ChatsListError(
          title: "Failed to fetch chats",
          description: message.toString(),
        ),
      );
    });

    on<LoadMoreChatsList>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final tokenId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<ChatListEntity>? chats,
        String? message,
      ) = await sl<GetChatsUseCase>().call(
        tokenId: tokenId!,
        page: page,
        limit: 12,
      );

      if (success && chats != null) {
        allChats.addAll(chats);
        StoryViewsManager.clearStoriesByChats(chats: chats);
        hasMore = chats.length == 12;
        page++;

        isLoading = false;
        emit(ChatsListPaginationSuccess(chats: chats));
        sl<WebSocketsServices>().emitjoinChats(
          roomIds: chats.map((chat) => chat.id).toList(),
        );
        return;
      }

      emit(
        ChatsListPaginationError(
          title: "Failed to load more chats",
          description: message.toString(),
        ),
      );
      isLoading = false;
    });

    on<UpdateMessageSeenStatus>((event, emit) {
      debugPrint("Got messages seen event on chatlist ${event.chatId}");

      for (var chat in allChats) {
        if (chat.id == event.chatId) {
          chat.lastMessage?.isSeenByOther = true;
        }
      }

      emit(SocketUpdateChatList(chats: List.from(allChats)));
    });

    on<UpdateLastMessage>((event, emit) {
      debugPrint(
        "Got last message update event on chatlist ${event.message.chat}",
      );
      for (var chat in allChats) {
        if (chat.id == event.message.chat) {
          chat.lastMessage = event.message;
          SoundEffectsUtils.receivedMessage();
          break;
        }
      }

      allChats.sort((a, b) {
        final aTime = a.lastMessage?.createdAt;
        final bTime = b.lastMessage?.createdAt;

        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;

        return bTime.compareTo(aTime);
      });

      emit(
        SocketUpdateChatList(
          chats: List.from(allChats),
          message: event.message,
        ),
      );
    });
  }
}
