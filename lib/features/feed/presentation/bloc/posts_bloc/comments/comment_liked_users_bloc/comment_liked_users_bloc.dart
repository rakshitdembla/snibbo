import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_states.dart';
import 'package:snibbo_app/service_locator.dart';

class CommentLikedUsersBloc extends Bloc<CommentLikedUsersEvents, CommentLikedUsersStates> {
  int page = 1;
  List<UserEntity> allUsers = [];
  bool hasMore = true;
  bool isLoading = false;
  String? userId;
  bool isSearchMode = false;

  CommentLikedUsersBloc() : super(CommentLikedUsersInitial()) {
    on<GetCommentLikedUsers>((event, emit) async {
      // 🔁 Reset before emitting
      page = 1;
      allUsers = [];
      hasMore = true;
      isLoading = false;
      isSearchMode = false;

      // Emit loading only if showloading is true
      if (event.showloading) {
        emit(CommentLikedUsersLoading(commentId: event.commentId));
      }

      userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getCommentLikedUsers(
        commentId: event.commentId,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allUsers.addAll(users);
        hasMore = users.length == 13;
        StoryViewsManager.clearStoriesByUsers(users: users);
        page = 2;

        emit(CommentLikedUsersLoaded(users: users, commentId: event.commentId));
        return;
      }

      emit(CommentLikedUsersError(
        title: "Failed to fetch liked users",
        descrition: message.toString(),
        commentId: event.commentId,
      ));
    });

    on<LoadMoreCommentLikedUsers>((event, emit) async {
      if (isLoading || !hasMore || isSearchMode) return;

      isLoading = true;
      if (userId == null) return;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getCommentLikedUsers(
        commentId: event.commentId,
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
        emit(CommentLikedUsersPaginationSuccess(users: users, commentId: event.commentId));
        return;
      }

      emit(CommentLikedUsersPaginationError(
        title: "Failed to load more liked users",
        descrition: message.toString(),
        commentId: event.commentId,
      ));
      isLoading = false;
    });

    // 🔍 Search
    on<SearchCommentLikedUser>((event, emit) async {
      allUsers = [];
      userId = userId ?? await ServicesUtils.getTokenId();
      isSearchMode = true;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().searchCommentLikedUser(
        commentId: event.commentId,
        userId: userId!,
        userToSearch: event.userToSearch,
      );

      allUsers = users ?? [];
      StoryViewsManager.clearStoriesByUsers(users: users ?? []);

      emit(CommentLikedUsersLoaded(users: users ?? [], commentId: event.commentId));
    });
  }
}
