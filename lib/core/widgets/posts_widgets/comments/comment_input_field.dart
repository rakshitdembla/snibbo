import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CommentInputField extends StatefulWidget {
  final PostEntity post;

  const CommentInputField({super.key, required this.post});

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final String hintText = "Write a comment...";

    return Material(
      elevation: 10.0,
      color: isDark ? MyColors.darkPrimary : MyColors.primary,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: 1,
                cursorColor: MyColors.secondaryDense,
                cursorErrorColor: MyColors.secondaryDense,
                minLines: 1,
                style: TextStyle(fontSize: width * 0.035),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: height * 0.016,
                    color: MyColors.grey,
                  ),
        
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
        
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    width * 0.035,
                    height * 0.015,
                    width * 0.01,
                    height * 0.015,
                  ),
                ),
                onSubmitted:
                    (value) => () {
                      BlocProvider.of<CreateCommentBloc>(context).add(
                        SubmitCommentEvent(
                          postId: widget.post.id,
                          commentContent: _controller.text.trim(),
                        ),
                      );
                    },
              ),
            ),
        
            BlocConsumer<CreateCommentBloc, CreateCommentState>(
              listener: (context, state) {
                if (state is CreateCommentSuccess) {
                  _controller.clear();
                  BlocProvider.of<GetPostCommentsBloc>(
                    context,
                  ).add(AddNewPostComment(postId: widget.post.id,comment: state.comment));
                  
                } else if (state is CreateCommentFailure) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                }
              },
              builder: (context, state) {
                if (state is CreateCommentLoading) {
                  return Padding(
                    padding: EdgeInsets.only(right: width * 0.025),
                    child: Center(child: CircularProgressLoading()));
                }
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<CreateCommentBloc>(context).add(
                      SubmitCommentEvent(
                        postId: widget.post.id,
                        commentContent: _controller.text.trim(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.send,
                    color: MyColors.secondaryDense,
                    size: width * 0.056,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
