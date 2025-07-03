import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/feed_mode_enums.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_states.dart';
import 'package:snibbo_app/service_locator.dart';

class PostPaginationBloc
    extends Bloc<PostPaginationEvents, PostPaginationStates> {
  int page = 1;
  bool isLoading = false;
  bool hasMoreFollowingPosts = true;
  bool hasMoreAllPosts = true;
  List<PostEntity> allposts = [];
  FeedMode currentFeedMode = FeedMode.following;

  PostPaginationBloc() : super(PostPaginationInitial()) {
    on<InitializePaginationPosts>((event, emit) {
      PostInteractionManager.clearPosts(posts: event.initialPosts);
      allposts = event.initialPosts;
      hasMoreFollowingPosts = event.initialPosts.length == 8;
      page = 2;
      currentFeedMode = FeedMode.following;
      emit(PostPaginationLoaded(postLists: allposts));
    });

    on<LoadMorePosts>((event, emit) async {
      if (isLoading) {
        return;
      }

      if (currentFeedMode == FeedMode.following && !hasMoreFollowingPosts) {
        page = 1;
        currentFeedMode = FeedMode.all;
      } else if (currentFeedMode == FeedMode.all && !hasMoreAllPosts) {
        return;
      }

      isLoading = true;
      final tokenId = await ServicesUtils.getTokenId();

      try {
        //@ If FeedMode is Following
        if (currentFeedMode == FeedMode.following) {
          final (success, newPosts, message) = await sl<GetFeedPostsUsecase>()
              .getFollowingPosts(tokenId!, page, 8);

          if (success && newPosts != null) {
            page++;
            allposts.addAll(newPosts);
            PostInteractionManager.clearPosts(posts: newPosts);
            hasMoreFollowingPosts = newPosts.length == 8;
            emit(PostPaginationLoaded(postLists: allposts));
          } else {
            emit(
              PostPaginationError(
                title: "Failed to fetch posts",
                description: message.toString(),
              ),
            );
          }
        }
        //@ If FeedMode is All
        else if (currentFeedMode == FeedMode.all) {
          final (success, newPosts, message) = await sl<GetFeedPostsUsecase>()
              .getAllPosts(tokenId!, page, 8);

          if (success && newPosts != null) {
            hasMoreAllPosts = newPosts.length == 8;
            page++;
            allposts.addAll(newPosts);
            emit(PostPaginationLoaded(postLists: allposts));
          } else {
            emit(
              PostPaginationError(
                title: "Failed to fetch posts",
                description: message.toString(),
              ),
            );
          }
        }
      } catch (e) {
        emit(
          PostPaginationError(
            title: "Failed to fetch posts",
            description: e.toString(),
          ),
        );
      } finally {
        isLoading = false;
      }
    });

    on<UpdateFeedPost>((event, emit) {
      emit(RefreshFeedPosts());
      if (allposts.isNotEmpty) {
        final index = allposts.indexWhere((post) => post.id == event.postId);

        if (index != -1) {
          allposts[index].postCaption = event.updatedCaptions.trim();
        }
      }

      emit(PostPaginationLoaded(postLists: List.from(allposts)));
    });

    on<DeleteFeedPost>((event, emit) {
      emit(RefreshFeedPosts());
      if (allposts.isNotEmpty) {
        final index = allposts.indexWhere((post) => post.id == event.postId);

        if (index != -1) {
          allposts.removeAt(index);
        }
      }

      emit(PostPaginationLoaded(postLists: List.from(allposts)));
    });
  }
}
