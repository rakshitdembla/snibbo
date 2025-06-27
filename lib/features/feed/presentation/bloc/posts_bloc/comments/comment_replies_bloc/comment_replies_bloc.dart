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
      if (isLoading || !hasMore) return;

      isLoading = true;
      allReplies = [];

      final userId = await ServicesUtils.getTokenId();
      final result = await sl<PostsUsecase>().getCommentReplies(
        commentId: event.commentId,
        userId: userId!,
        page: page,
        limit: 4,
      );

      if (result.success && result.commentReplies != null) {
        final fetchedReplies = result.commentReplies!;
        allReplies.addAll(fetchedReplies);

        hasMore = fetchedReplies.length == 4;
        page++;

        emit(
          GetCommentRepliesLoaded(
            replies: result.commentReplies ?? [],
            commentId: event.commentId,
          ),
        );
      } else {
        emit(
          GetCommentRepliesError(
            title: "Failed to Load Replies",
            description: result.message ?? "An unknown error occurred",
            commentId: event.commentId,
          ),
        );
      }

      isLoading = false;
    });

    on<ResetCommentsReplies>((event, emit) {
      page = 1;
      allReplies = [];
      isLoading = false;
      hasMore = true;
    });

    on<AddNewCommentReply>((event, emit) {
      final reply = event.reply;

      allReplies.insert(0, reply);

      emit(
        GetCommentRepliesLoaded(
          replies: List.from(allReplies),
          commentId: event.commentId,
        ),
      );
    });
  }
}
