import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_saved_posts.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserSavedPostsPaginationBloc
    extends Bloc<UserSavedPostsPaginationEvents, UserSavedPostsPaginationStates> {
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<PostEntity> allSavedPosts = [];

  UserSavedPostsPaginationBloc() : super(UserSavedPostsPaginationInitial()) {
    on<InitializeUserSavedPosts>((event, emit) {
      allSavedPosts = event.initialPosts;
      page = 2;
      hasMore = event.initialPosts.length == 15;
      emit(UserSavedPostsPaginationLoaded(postLists: allSavedPosts,username: event.username ));
    });

    on<LoadMoreSavedPosts>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;

      final tokenId = await ServicesUtils.getTokenId();

      try {
        final (
          success,
          posts,
          message,
        ) = await sl<GetUserSavedPostsUsecase>().call(
          userId: tokenId!,
          username: event.username,
          page: page,
          limit: 15,
        );

        if (success && posts != null) {
          page++;
          hasMore = posts.length == 15;
          allSavedPosts.addAll(posts);
          emit(UserSavedPostsPaginationLoaded(postLists: posts,username: event.username));
        } else {
          emit(UserSavedPostsPaginationError(
            username: event.username,
            title: "Failed to load saved posts",
            description: message ?? "An unknown error occurred.",
          ));
        }
      } catch (e) {
        emit(UserSavedPostsPaginationError(
          username: event.username,
          title: "Something went wrong",
          description: e.toString(),
        ));
      }

      isLoading = false;
    });

        on<ReloadInitialUserSavedPosts>((event, emit) async {
      emit(ReloadUserSavedLoading(username: event.username));
      page = 1;
      isLoading = false;
      allSavedPosts = [];
      final tokenId = await ServicesUtils.getTokenId();

      final (success, posts, message) = await sl<GetUserSavedPostsUsecase>().call(
        userId: tokenId!,
        username: event.username,
        page: page,
        limit: 15,
      );

      if (success && posts != null) {
        hasMore = posts.length == 15;
        page = 2;
        allSavedPosts.addAll(posts);
        emit(
          UserSavedPostsPaginationLoaded(
            username: event.username,
            postLists: posts,
          ),
        );
        return;
      }

      emit(
        UserSavedPostsPaginationError(
          username: event.username,
          title: "Failed to load more user posts",
          description: message ?? "An unknown error occurred.",
        ),
      );
    });
  }
}
