import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_states.dart';
import 'package:snibbo_app/service_locator.dart';

class StoryPaginationBloc
    extends Bloc<StoryPaginationEvents, StoryPaginationStates> {
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<UserEntity> allStories = [];

  StoryPaginationBloc() : super(StoryPaginationInitial()) {
    on<InitializePaginationStories>((event, emit) {
      allStories = event.initialStories;
      page = 2;
      hasMore = event.initialStories.length == 7;
      emit(StoryPaginationLoaded(storiesList: allStories, hasMore: hasMore));
    });

    on<LoadMoreUserStories>((event, emit) async {
      if (isLoading || !hasMore) {
        return;
      }
      isLoading = true;
      emit(StoryPaginationLoading());
      final tokenId = await ServicesUtils.getTokenId();

      try {
        final (
          storiesSuccess,
          stories,
          storiesMessage,
        ) = await sl<GetFeedPostsUsecase>().getFollowingStories(
          tokenId: tokenId!,
          page: page,
          limit: 7,
        );

        if (storiesSuccess && stories != null) {
          page++;

          hasMore = stories.length == 7;

          allStories.addAll(stories);
          emit(
            StoryPaginationLoaded(storiesList: allStories, hasMore: hasMore),
          );
        } else {
          emit(
            StoryPaginationError(
              title: "Failed to load more stories",
              description: storiesMessage ?? "An unknown error occurred.",
            ),
          );
        }
      } catch (e) {
        emit(
          StoryPaginationError(
            title: "Something went wrong",
            description: e.toString(),
          ),
        );
      }

      isLoading = false;
    });
  }
}
