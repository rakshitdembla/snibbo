import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ReplyLikedUsersBloc extends Bloc<ReplyLikedUsersEvents, ReplyLikedUsersStates> {
  int page = 1;
  List<UserEntity> allUsers = [];
  bool hasMore = true;
  bool isLoading = false;
  String? userId;
  bool isSearchMode = false;

  ReplyLikedUsersBloc() : super(ReplyLikedUsersInitial()) {
    on<GetReplyLikedUsers>((event, emit) async {
      page = 1;
      allUsers = [];
      hasMore = true;
      isLoading = false;
      isSearchMode = false;

      if (event.showloading) {
        emit(ReplyLikedUsersLoading(replyId: event.replyId));
      }

      userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getReplyLikedUsers(
        replyId: event.replyId,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allUsers.addAll(users);
        hasMore = users.length == 13;
        page = 2;
        StoryViewsManager.clearStoriesByUsers(users: users);

        emit(ReplyLikedUsersLoaded(users: users, replyId: event.replyId));
        return;
      }

      emit(ReplyLikedUsersError(
        title: "Failed to fetch liked users",
        descrition: message.toString(),
        replyId: event.replyId,
      ));
    });

    on<LoadMoreReplyLikedUsers>((event, emit) async {
      if (isLoading || !hasMore || isSearchMode) return;

      isLoading = true;
      if (userId == null) return;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getReplyLikedUsers(
        replyId: event.replyId,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allUsers.addAll(users);
        hasMore = users.length == 13;
        page++;
        StoryViewsManager.clearStoriesByUsers(users: users);

        isLoading = false;
        emit(ReplyLikedUsersPaginationSuccess(users: users, replyId: event.replyId));
        return;
      }

      emit(ReplyLikedUsersPaginationError(
        title: "Failed to load more liked users",
        descrition: message.toString(),
        replyId: event.replyId,
      ));
      isLoading = false;
    });

    on<SearchReplyLikedUser>((event, emit) async {
      allUsers = [];
      userId = userId ?? await ServicesUtils.getTokenId();
      isSearchMode = true;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().searchReplyLikedUser(
        replyId: event.replyId,
        userId: userId!,
        userToSearch: event.userToSearch,
      );

      allUsers = users ?? [];
      StoryViewsManager.clearStoriesByUsers(users: users ?? []);

      emit(ReplyLikedUsersLoaded(users: users ?? [], replyId: event.replyId));
    });
  }
}
