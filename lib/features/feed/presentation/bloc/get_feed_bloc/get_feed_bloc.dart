import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_states.dart';
import 'package:snibbo_app/service_locator.dart';

class GetFeedBloc extends Bloc<GetFeedEvents, GetFeedStates> {
  GetFeedBloc() : super(GetFeedInitialState()) {
    on<GetFeedData>((event, emit) async {
      emit(GetFeedLoadingState());

      final tokenId = await ServicesUtils.getTokenId();
      debugPrint("token id : $tokenId");

      final (
        postsSuccess,
        posts,
        postsMessage,
      ) = await sl<GetFeedPostsUsecase>().getFollowingPosts(tokenId!, 1, 8);

      final (
        storiesSuccess,
        stories,
        storiesMessage,
      ) = await sl<GetFeedPostsUsecase>().getFollowingStories(
        tokenId: tokenId,
        page: 1,
        limit: 15,
      );

      final (
        myStoriesSuccess,
        myStories,
        myStoriesMesssage,
      ) = await sl<GetFeedPostsUsecase>().getMyStories(tokenId);

      if (postsSuccess &&
          storiesSuccess &&
          myStoriesSuccess &&
          posts != null &&
          stories != null &&
          myStories != null) {
        if (posts.isEmpty || posts.length < 3) {
          final (
            allPostsSuccess,
            allPosts,
            allPostsMessage,
          ) = await sl<GetFeedPostsUsecase>().getAllPosts(tokenId, 1, 15);

          if (allPostsSuccess && allPosts != null) {
            posts.addAll(allPosts);
          } else {
            emit(
              GetFeedErrorState(
                title: "Failed to Load Feed",
                description: "An unknown error occurred.",
              ),
            );
            return;
          }
        }
        
        emit(
          GetFeedSuccessState(
            title: "Feed Loaded",
            description: "Your posts and stories were fetched successfully.",
            postsList: posts,
            storiesList: stories,
            myStories: myStories,
          ),
        );
        return;
      }

      emit(
        GetFeedErrorState(
          title: "Failed to Load Feed",
          description: "An unknown error occurred.",
        ),
      );
    });
  }
}
