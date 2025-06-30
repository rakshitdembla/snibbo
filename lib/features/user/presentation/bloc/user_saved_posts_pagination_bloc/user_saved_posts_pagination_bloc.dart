import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_saved_posts.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_saved_posts_helper.dart';
import 'package:snibbo_app/service_locator.dart';

class UserSavedPostsPaginationBloc
    extends
        Bloc<UserSavedPostsPaginationEvents, UserSavedPostsPaginationStates> {
  UserSavedPostsPaginationBloc() : super(UserSavedPostsPaginationInitial()) {
    final allPosts = UserSavedPostsHelper.posts;
    final hasMore = UserSavedPostsHelper.hasMore;
    final isLoading = UserSavedPostsHelper.isLoading;
    final page = UserSavedPostsHelper.page;

    on<InitializeUserSavedPosts>((event, emit) {
      isLoading[event.username] = false;
      allPosts[event.username] = event.initialPosts;
      page[event.username] = 2;
      hasMore[event.username] = event.initialPosts.length == 15;
      emit(
        UserSavedPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });

    on<LoadMoreSavedPosts>((event, emit) async {
      if (isLoading[event.username]! || !hasMore[event.username]!) return;

      debugPrint("Got saved posts load event!!");
      isLoading[event.username] = true;

      final tokenId = await ServicesUtils.getTokenId();

      try {
        final (success, posts, message) = await sl<GetUserSavedPostsUsecase>()
            .call(
              userId: tokenId!,
              username: event.username,
              page: page[event.username]!,
              limit: 15,
            );

        if (success && posts != null) {
          page[event.username] = page[event.username]! + 1;
          hasMore[event.username] = posts.length == 15;
          allPosts[event.username]!.addAll(posts);
          emit(
            UserSavedPostsPaginationLoaded(
              postLists: posts,
              username: event.username,
            ),
          );

          debugPrint("Emitted success for saved posts");
        } else {
          emit(
            UserSavedPostsPaginationError(
              username: event.username,
              title: "Failed to load saved posts",
              description: message ?? "An unknown error occurred.",
            ),
          );
        }
      } catch (e) {
        emit(
          UserSavedPostsPaginationError(
            username: event.username,
            title: "Something went wrong",
            description: e.toString(),
          ),
        );
      }

      isLoading[event.username] = false;
    });

    on<UpdateUserSavedPost>((event, emit) {
      emit(RefreshUserSavedPostsPagination(username: event.username));
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
        UserSavedPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });

    on<DeleteUserSavedPost>((event, emit) {
      emit(RefreshUserSavedPostsPagination(username: event.username));
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
        UserSavedPostsPaginationLoaded(
          postLists: allPosts[event.username] ?? [],
          username: event.username,
        ),
      );
    });
  }
}
