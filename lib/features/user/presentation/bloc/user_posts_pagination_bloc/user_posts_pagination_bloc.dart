import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_posts_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_posts_helper.dart';
import 'package:snibbo_app/service_locator.dart';

class UserPostsPaginationBloc
    extends Bloc<UserPostsPaginationEvents, UserPostsPaginationStates> {
  UserPostsPaginationBloc() : super(UserPostsPaginationInitial()) {
    final allPosts = UserPostsHelper.posts;
    final hasMore = UserPostsHelper.hasMore;
    final isLoading = UserPostsHelper.isLoading;
    final page = UserPostsHelper.page;

    on<InitializeUserPosts>((event, emit) {
      PostInteractionManager.clearPosts(posts: event.initialPosts);
      isLoading[event.username] = false;
      allPosts[event.username] = event.initialPosts;
      page[event.username] = 2;
      hasMore[event.username] = event.initialPosts.length == 15;
      emit(
        UserPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });

    on<LoadMoreUserPosts>((event, emit) async {
      if (isLoading[event.username]! || !hasMore[event.username]!) {
        return;
      }
      isLoading[event.username] = true;
      final tokenId = await ServicesUtils.getTokenId();

      try {
        final (success, posts, message) = await sl<GetUserPostsUsecase>().call(
          userId: tokenId!,
          username: event.username,
          page: page[event.username]!,
          limit: 15,
        );

        if (success && posts != null) {
           PostInteractionManager.clearPosts(posts: posts);

          page[event.username] = page[event.username]! + 1;

          hasMore[event.username] = posts.length == 15;

          allPosts[event.username]!.addAll(posts);
          emit(
            UserPostsPaginationLoaded(
              postLists: posts,
              username: event.username,
            ),
          );
        } else {
          emit(
            UserPostsPaginationError(
              username: event.username,
              title: "Failed to load more user posts",
              description: message ?? "An unknown error occurred.",
            ),
          );
        }
      } catch (e) {
        emit(
          UserPostsPaginationError(
            username: event.username,
            title: "Something went wrong",
            description: e.toString(),
          ),
        );
      }

      isLoading[event.username] = false;
    });

    on<UpdateUserPost>((event, emit) {
      emit(RefreshUserPostsPagination(username: event.username));
      if (allPosts[event.username] != null &&
          allPosts[event.username]!.isNotEmpty) {
        final index = allPosts[event.username]!.indexWhere(
          (post) => post.id == event.postId,
        );

        if (index != -1) {
          allPosts[event.username]![index].postCaption =
              event.updatedCaptions.trim();
        }
      }

      emit(
        UserPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });

    on<DeleteUserPost>((event, emit) {
      emit(RefreshUserPostsPagination(username: event.username));
      if (allPosts[event.username] != null &&
          allPosts[event.username]!.isNotEmpty) {
        final index = allPosts[event.username]!.indexWhere(
          (post) => post.id == event.postId,
        );

        if (index != -1) {
          allPosts[event.username]!.removeAt(index);
        }
      }

      emit(
        UserPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });
  }
}
