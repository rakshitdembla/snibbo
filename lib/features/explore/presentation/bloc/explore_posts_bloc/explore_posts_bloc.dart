import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/explore/domain/use_cases/get_explore_posts.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_events.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_states.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class ExplorePostsBloc extends Bloc<ExplorePostsEvents, ExplorePostsStates> {
  int page = 1;
  List<PostEntity> allPosts = [];
  bool hasMore = true;
  bool isLoading = false;

  ExplorePostsBloc() : super(ExplorePostsInitial()) {
    on<GetPosts>((event, emit) async {
      emit(ExplorePostsLoading());
      final userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<PostEntity>? posts,
        String? message,
      ) = await sl<GetExplorePostsUsecase>().call(
        userId: userId!,
        page: page,
        limit: 20,
      );

      if (success && posts != null) {
        allPosts.addAll(posts);

        hasMore = posts.length == 20;

        page = 2;

        emit(ExplorePostsLoaded(posts: posts));

        return;
      }

      emit(
        ExplorePostsError(
          descrition: message.toString(),
          title: "Failed to fetch posts",
        ),
      );
    });

    on<LoadMoreExplorePosts>((event, emit) async {
      if (isLoading || !hasMore) {
        return;
      }
      isLoading = true;

      final userId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<PostEntity>? posts,
        String? message,
      ) = await sl<GetExplorePostsUsecase>().call(
        userId: userId!,
        page: page,
        limit: 20,
      );

      if (success && posts != null) {
        allPosts.addAll(posts);

        hasMore = posts.length == 20;

        page++;

        isLoading = false;
        emit(ExplorePaginationSuccess(posts: posts));
        return;
      }

      emit(
        ExplorePaginationError(
          descrition: message.toString(),
          title: "Failed to load more posts",
        ),
      );
      isLoading = false;
    });

    on<UpdateExplorePost>((event, emit) {
      emit(ExplorePostsLoading());

      if (allPosts.isNotEmpty) {
        final index = allPosts.indexWhere((post) => post.id == event.postId);

        if (index != -1) {
          allPosts[index].postCaption = event.updatedCaptions.trim();
        }
      }

      emit(ExplorePostsLoaded(posts: allPosts));
    });

    on<DeleteExplorePost>((event, emit) {
      emit(ExplorePostsLoading());

      if (allPosts.isNotEmpty) {
        final index = allPosts.indexWhere((post) => post.id == event.postId);

        if (index != -1) {
          allPosts.removeAt(index);
        }
      }

      emit(ExplorePostsLoaded(posts: allPosts));
    });
  }
}
