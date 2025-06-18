import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_states.dart';
import 'package:snibbo_app/service_locator.dart';

class PostLikedUsersBloc extends Bloc<PostLikedUsersEvents, PostLikedUsersStates> {
  int page = 1;
  List<UserEntity> allUsers = [];
  bool hasMore = true;
  bool isLoading = false;

  PostLikedUsersBloc() : super(PostLikedUsersInitial()) {
    on<GetPostLikedUsers>((event, emit) async {
      emit(PostLikedUsersLoading(postId: event.postId));

      // Reset
      page = 1;
      allUsers = [];
      hasMore = true;
      isLoading = false;

      final userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getPostLikedUsers(
        postId: event.postId,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allUsers.addAll(users);
        hasMore = users.length == 13;
        page = 2;

        emit(PostLikedUsersLoaded(users: users, postId: event.postId));
        return;
      }

      emit(PostLikedUsersError(
        title: "Failed to fetch liked users",
        descrition: message.toString(),
        postId: event.postId,
      ));
    });

    on<LoadMorePostLikedUsers>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().getPostLikedUsers(
        postId: event.postId,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allUsers.addAll(users);
        hasMore = users.length == 13;
        page++;

        isLoading = false;
        emit(PostLikedUsersPaginationSuccess(users: users, postId: event.postId));
        return;
      }

      emit(PostLikedUsersPaginationError(
        title: "Failed to load more liked users",
        descrition: message.toString(),
        postId: event.postId,
      ));
      isLoading = false;
    });
  }
}
