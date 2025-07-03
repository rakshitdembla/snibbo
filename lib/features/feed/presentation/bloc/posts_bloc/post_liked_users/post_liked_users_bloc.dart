import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_states.dart';
import 'package:snibbo_app/service_locator.dart';

class PostLikedUsersBloc
    extends Bloc<PostLikedUsersEvents, PostLikedUsersStates> {
  int page = 1;
  List<UserEntity> allUsers = [];
  bool hasMore = true;
  bool isLoading = false;
  String? userId;
  bool isSearchMode = false;

  PostLikedUsersBloc() : super(PostLikedUsersInitial()) {
    on<GetPostLikedUsers>((event, emit) async {
      // Reset
      page = 1;
      allUsers = [];
      hasMore = true;
      isSearchMode = false;
      isLoading = false;

      event.showloading
          ? emit(PostLikedUsersLoading(postId: event.postId))
          : null;

      userId = await ServicesUtils.getTokenId();
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
        StoryViewsManager.clearStoriesByUsers(users: users);

        emit(PostLikedUsersLoaded(users: users, postId: event.postId));
        return;
      }

      emit(
        PostLikedUsersError(
          title: "Failed to fetch liked users",
          descrition: message.toString(),
          postId: event.postId,
        ),
      );
    });

    on<LoadMorePostLikedUsers>((event, emit) async {
      if (isLoading || !hasMore || isSearchMode) return;

      isLoading = true;
      if (userId == null) {
        return;
      }

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
        StoryViewsManager.clearStoriesByUsers(users: users);

        isLoading = false;
        emit(
          PostLikedUsersPaginationSuccess(users: users, postId: event.postId),
        );
        return;
      }

      emit(
        PostLikedUsersPaginationError(
          title: "Failed to load more liked users",
          descrition: message.toString(),
          postId: event.postId,
        ),
      );
      isLoading = false;
    });

    on<SearchUser>((event, emit) async {
      allUsers = [];
      userId = userId ?? await ServicesUtils.getTokenId();
      isSearchMode = true;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<PostsUsecase>().searchPostLikedUser(
        postId: event.postId,
        userId: userId!,
        userToSearch: event.userToSearch,
      );

      allUsers = users ?? [];
      StoryViewsManager.clearStoriesByUsers(users: users ?? []);

      emit(PostLikedUsersLoaded(users: users ?? [], postId: event.postId));
    });
  }
}
