import 'package:bloc/bloc.dart';
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

  CommentLikedUsersBloc() : super(CommentLikedUsersInitial()) {
    on<GetCommentLikedUsers>((event, emit) async {
      emit(CommentLikedUsersLoading(commentId: event.commentId));

      page = 1;
      allUsers = [];
      hasMore = true;
      isLoading = false;

      final userId = await ServicesUtils.getTokenId();
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
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();

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
  }
}
