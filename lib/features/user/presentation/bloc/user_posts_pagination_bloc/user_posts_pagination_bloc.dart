import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_posts_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserPostsPaginationBloc
    extends Bloc<UserPostsPaginationEvents, UserPostsPaginationStates> {
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<PostEntity> allUserPosts = [];

  UserPostsPaginationBloc() : super(UserPostsPaginationInitial()) {
    on<InitializeUserPosts>((event, emit) {
      allUserPosts = event.initialPosts;
      page = 2;
      hasMore = event.initialPosts.length == 15;
      emit(
        UserPostsPaginationLoaded(
          postLists: allUserPosts,
          username: event.username,
        ),
      );
    });

    on<LoadMoreUserPosts>((event, emit) async {
      if (isLoading || !hasMore) {
        return;
      }
      isLoading = true;
      final tokenId = await ServicesUtils.getTokenId();

      try {
        final (success, posts, message) = await sl<GetUserPostsUsecase>().call(
          userId: tokenId!,
          username: event.username,
          page: page,
          limit: 15,
        );

        if (success && posts != null) {
          page++;

          hasMore = posts.length == 15;

          allUserPosts.addAll(posts);
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

      isLoading = false;
    });

    on<ReloadInitialUserPosts>((event, emit) async {
      emit(ReloadUserPostsLoading(username: event.username));
      page = 1;
      isLoading = false;
      allUserPosts = [];
      final tokenId = await ServicesUtils.getTokenId();

      final (success, posts, message) = await sl<GetUserPostsUsecase>().call(
        userId: tokenId!,
        username: event.username,
        page: page,
        limit: 15,
      );

      if (success && posts != null) {
        hasMore = posts.length == 15;
        page = 2;
        allUserPosts.addAll(posts);
        emit(
          UserPostsPaginationLoaded(
            username: event.username,
            postLists: posts,
          ),
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
