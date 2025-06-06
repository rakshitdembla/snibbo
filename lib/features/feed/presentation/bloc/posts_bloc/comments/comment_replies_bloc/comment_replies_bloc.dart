import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_states.dart';
import 'package:snibbo_app/service_locator.dart';

class GetCommentRepliesBloc
    extends Bloc<GetCommentRepliesEvents, GetCommentRepliesStates> {
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;
  List<CommentReplyEntity> allReplies = [];

  GetCommentRepliesBloc() : super(GetCommentRepliesInitial()) {
    on<FetchCommentReplies>((event, emit) async {
      final userId = await ServicesUtils.getTokenId();

      final result = await sl<PostsUsecase>().getCommentReplies(
        commentId: event.commentId,
        userId: userId!,
        page: page,
        limit: 4,
      );

      if (result.success && result.commentReplies != null) {
        allReplies.addAll(result.commentReplies!);
        hasMore = result.commentReplies!.length == 4;
        page = 2;

        emit(GetCommentRepliesLoaded(replies: allReplies));
        return;
      }

      emit(
        GetCommentRepliesError(
          title: "Failed to Load Replies",
          description: result.message ?? "An unknown error occurred",
        ),
      );
    });

    on<LoadMoreCommentReplies>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();

      final result = await sl<PostsUsecase>().getCommentReplies(
        commentId: event.commentId,
        userId: userId!,
        page: page,
        limit: 4,
      );

      if (result.success && result.commentReplies != null) {
        allReplies.addAll(result.commentReplies!);
        hasMore = result.commentReplies!.length == 4;
        page++;

        isLoading = false;
        emit(GetCommentRepliesPaginationSuccess(replies: allReplies));
        return;
      }

      emit(
        GetCommentRepliesPaginationError(
          title: "Failed to load more replies",
          description: result.message ?? "Something went wrong",
        ),
      );

      isLoading = false;
    });
  }
}
