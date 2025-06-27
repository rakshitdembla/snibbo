import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_posts_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_posts_helper.dart';
import 'package:snibbo_app/service_locator.dart';

class UserPostsPaginationBloc
    extends Bloc<UserPostsPaginationEvents, UserPostsPaginationStates> {
  UserPostsPaginationBloc() : super(UserPostsPaginationInitial()) {
    final allPosts = UserPostsHelper.posts;
    final hasMore = UserPostsHelper.hasMore;
    final isLoading = UserPostsHelper.isLoading;
    final page = UserPostsHelper.page;

    on<InitializeUserPosts>((event, emit) {
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

      debugPrint("Got event!!");
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
          page[event.username] = page[event.username]! + 1;

          hasMore[event.username] = posts.length == 15;

          allPosts[event.username]!.addAll(posts);
          emit(
            UserPostsPaginationLoaded(
              postLists: posts,
              username: event.username,
            ),
          );

          debugPrint("emitted sucecess");
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

    on<ReloadInitialUserPosts>((event, emit) async {
      emit(ReloadUserPostsLoading(username: event.username));
      page[event.username] = 1;
      isLoading[event.username] = false;
      allPosts[event.username] = [];
      final tokenId = await ServicesUtils.getTokenId();

      final (success, posts, message) = await sl<GetUserPostsUsecase>().call(
        userId: tokenId!,
        username: event.username,
        page: page[event.username]!,
        limit: 15,
      );

      if (success && posts != null) {
        hasMore[event.username] = posts.length == 15;
        page[event.username] = 2;
        allPosts[event.username]!.addAll(posts);
        emit(
          UserPostsPaginationLoaded(username: event.username, postLists: posts),
        );
        return;
      }

      emit(
        UserPostsPaginationError(
          username: event.username,
          title: "Failed to load more user posts",
          description: message ?? "An unknown error occurred.",
        ),
      );
    });
  }
}
