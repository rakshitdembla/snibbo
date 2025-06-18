import 'package:flutter_bloc/flutter_bloc.dart';
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
        hasMore = chats.length == 12;
        page = 2;

        emit(ChatsListLoaded(chats: chats));
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
        hasMore = chats.length == 12;
        page++;

        isLoading = false;
        emit(ChatsListPaginationSuccess(chats: chats));
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
  }
}
