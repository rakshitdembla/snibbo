import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_states.dart';
import 'package:snibbo_app/service_locator.dart';

class GetPostCommentsBloc
    extends Bloc<GetPostCommentsEvents, GetPostCommentsStates> {
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;
  List<PostCommentEntity> allComments = [];

  GetPostCommentsBloc() : super(GetPostCommentsInitial()) {
    on<FetchPostComments>((event, emit) async {
      emit(GetPostCommentsLoading(postId: event.postId));
      page = 1;
      hasMore = true;
      isLoading = false;
      allComments = [];
      final userId = await ServicesUtils.getTokenId();
      final result = await sl<PostsUsecase>().getPostComments(
        postId: event.postId,
        userId: userId!,
        page: page,
        limit: 8,
      );

      if (result.success && result.postComments != null) {
        allComments.addAll(result.postComments ?? []);
        hasMore = result.postComments?.length == 8;
        page = 2;

        emit(
          GetPostCommentsLoaded(
            comments: result.postComments ?? [],
            postId: event.postId,
          ),
        );
        return;
      }

      emit(
        GetPostCommentsError(
          title: "Failed to Load Comments",
          description: result.message ?? "An unknown error occurred",
          postId: event.postId,
        ),
      );
    });

    on<LoadMorePostComments>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();
      final result = await sl<PostsUsecase>().getPostComments(
        postId: event.postId,
        userId: userId!,
        page: page,
        limit: 8,
      );

      if (result.success && result.postComments != null) {
        allComments.addAll(result.postComments ?? []);
        hasMore = result.postComments?.length == 8;
        page++;

        isLoading = false;
        emit(
          GetPostCommentsLoaded(
            comments: result.postComments ?? [],
            postId: event.postId,
          ),
        );
        return;
      }

      emit(
        GetPostCommentsPaginationError(
          title: "Failed to load more comments",
          description: result.message ?? "Something went wrong",
          postId: event.postId
        ),
      );

      isLoading = false;
    });
  }
}
