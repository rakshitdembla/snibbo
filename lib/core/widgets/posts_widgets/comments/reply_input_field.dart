import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class ReplyInputField extends StatefulWidget {
  final PostCommentEntity comment;
  final PostEntity post;

  const ReplyInputField({super.key, required this.comment, required this.post});

  @override
  State<ReplyInputField> createState() => _ReplyInputFieldState();
}

class _ReplyInputFieldState extends State<ReplyInputField> {
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
    final String hintText = "Add a reply...";

    return Material(
      elevation: 10.0,
      color: isDark ? MyColors.darkPrimary : MyColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.005),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2F33) : const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Replying to @${widget.comment.userId.username}",
                    style: TextStyle(fontSize: height * 0.013),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: width * 0.02),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<InputFieldBloc>(
                        context,
                      ).add(ShowCommentField(post: widget.post));
                    },
                    child: Icon(
                      LineIcons.times,
                      color: isDark ? MyColors.primary : MyColors.darkPrimary,
                      size: height * 0.0165,
                    ),
                  ),
                ],
              ),
            ),
            Row(
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
                        overflow: TextOverflow.ellipsis,
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
                    onSubmitted: (value) {
                      BlocProvider.of<CreateReplyBloc>(context).add(
                        SubmitReplyEvent(
                          commentId: widget.comment.id,
                          replyContent: _controller.text.trim(),
                        ),
                      );
                    },
                  ),
                ),
                BlocConsumer<CreateReplyBloc, CreateReplyState>(
                  listener: (context, state) {
                    if (state is CreateReplyFailure) {
                      UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                } else if (state is CreateReplySuccess) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: true,
                    isWarning: false,
                  );
                  _controller.clear();
                  BlocProvider.of<GetPostCommentsBloc>(
                    context,
                  ).add(FetchPostComments(postId: widget.post.id));
                }
        
                  },
                  builder: (context, state) {
                  if (state is CreateReplyLoading) 
                  {
                    return Padding(
                    padding: EdgeInsets.only(right: width * 0.025),
                    child: Center(child: CircularProgressLoading()));
                  }
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<CreateReplyBloc>(context).add(
                          SubmitReplyEvent(
                            commentId: widget.comment.id,
                            replyContent: _controller.text.trim(),
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
          ],
        ),
      ),
    );
  }
}
