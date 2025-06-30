import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_states.dart';
import 'package:snibbo_app/core/local_data_manager/replies_storage_helper.dart';
import 'package:snibbo_app/service_locator.dart';

class GetCommentRepliesBloc
    extends Bloc<GetCommentRepliesEvents, GetCommentRepliesStates> {
  GetCommentRepliesBloc() : super(GetCommentRepliesInitial()) {
    final replies = ReplyStorageHelper.replies;
    final hasMore = ReplyStorageHelper.hasMore;
    final isLoading = ReplyStorageHelper.isLoading;
    final repliesLength = ReplyStorageHelper.repliesLength;
    final page = ReplyStorageHelper.page;

    on<FetchCommentReplies>((event, emit) async {
      if (isLoading[event.commentId] == true ||
          hasMore[event.commentId] == false) {
        return;
      }
      emit(GetCommentRepliesLoading(commentId: event.commentId));

      isLoading[event.commentId] = true;

      replies.putIfAbsent(event.commentId, () => []);

      //Call Api
      try {
        final userId = await ServicesUtils.getTokenId();
        final result = await sl<PostCommentsRepository>().getCommentReplies(
          commentId: event.commentId,
          userId: userId!,
          page: (page[event.commentId] ?? 1),
          limit: 4,
        );

        final allReplies = replies[event.commentId]!;

        if (result.success == true && result.commentReplies != null) {
          for (var reply in result.commentReplies!) {
            if (!allReplies.any((r) => r.id == reply.id)) {
              allReplies.add(reply);
            }
          }

          page[event.commentId] = (page[event.commentId] ?? 1) + 1;
          hasMore[event.commentId] = result.commentReplies!.length >= 4;
          isLoading[event.commentId] = false;

          emit(
            GetCommentRepliesLoaded(
              replies: result.commentReplies!,
              commentId: event.commentId,
            ),
          );
        } else {
          isLoading[event.commentId] = false;
          emit(
            GetCommentRepliesError(
              title: "Failed to fetch replies.",
              description: result.message.toString(),
              commentId: event.commentId,
            ),
          );
        }
      } catch (e) {
        emit(
          GetCommentRepliesError(
            title: "Failed to fetch replies.",
            description: e.toString(),
            commentId: event.commentId,
          ),
        );
      }
    });

    on<ResetCommentsReplies>((event, emit) {
      replies[event.commentId] = [];
      isLoading[event.commentId] = false;
      hasMore[event.commentId] = true;
      page[event.commentId] = 1;
    });

    on<AddNewCommentReply>((event, emit) {
      final reply = event.reply;

      replies.putIfAbsent(event.commentId, () => []);

      repliesLength[event.commentId] =
          (repliesLength[event.commentId] ?? 0) + 1;

      replies[event.commentId]!.insert(0, reply);

      emit(
        GetCommentRepliesLoaded(replies: [reply], commentId: event.commentId),
      );
    });

    on<RemoveCommentReply>((event, emit) {
      final repliesList = ReplyStorageHelper.replies[event.commentId];

      if (repliesList != null) {
        final index = repliesList.indexWhere(
          (reply) => reply.id == event.replyId,
        );

        if (index != -1) {
          repliesList.removeAt(index);
          repliesLength[event.commentId] =
              (repliesLength[event.commentId] ?? 1) - 1;
        }
      }

      emit(
        GetCommentRepliesLoaded(
          replies: repliesList ?? [],
          commentId: event.commentId,
        ),
      );
    });
  }
}
