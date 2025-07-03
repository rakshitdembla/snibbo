import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/network/helpers/search_debouncing.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/explore/presentation/widgets/search_field.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class ReplyLikedUsersScreen extends StatefulWidget {
  final CommentReplyEntity reply;
  const ReplyLikedUsersScreen({super.key, required this.reply});

  @override
  State<ReplyLikedUsersScreen> createState() => _ReplyLikedUsersScreenState();
}

class _ReplyLikedUsersScreenState extends State<ReplyLikedUsersScreen> {
  late ScrollController _controller;
  late ReplyLikedUsersBloc replyLikedUsersBloc;
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  final SearchDebouncingHelper _debounce = SearchDebouncingHelper();

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (replyLikedUsersBloc.hasMore && !replyLikedUsersBloc.isLoading) {
        replyLikedUsersBloc.add(LoadMoreReplyLikedUsers(replyId: widget.reply.id));
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<ReplyLikedUsersBloc>(context).add(
      GetReplyLikedUsers(replyId: widget.reply.id, showloading: true),
    );
    _controller = ScrollController();
    replyLikedUsersBloc = context.read<ReplyLikedUsersBloc>();
    _controller.addListener(_listener);
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Liked by"),
      ),
      body: MyRefreshBar(
        onRefresh: () async {
          textEditingController.clear();
          BlocProvider.of<ReplyLikedUsersBloc>(context).add(
            GetReplyLikedUsers(replyId: widget.reply.id, showloading: true),
          );
        },
        widget: BlocConsumer<ReplyLikedUsersBloc, ReplyLikedUsersStates>(
          listenWhen: (previous, current) {
            if (current is ReplyLikedUsersError) {
              return current.replyId == widget.reply.id;
            } else if (current is ReplyLikedUsersPaginationError) {
              return current.replyId == widget.reply.id;
            }
            return false;
          },
          listener: (context, state) {
            if (state is ReplyLikedUsersError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.descrition,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            } else if (state is ReplyLikedUsersPaginationError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.descrition,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            }
          },
          buildWhen: (previous, current) {
            if (current is ReplyLikedUsersLoading) {
              return current.replyId == widget.reply.id;
            } else if (current is ReplyLikedUsersError) {
              return current.replyId == widget.reply.id;
            } else if (current is ReplyLikedUsersLoaded) {
              return current.replyId == widget.reply.id;
            } else if (current is ReplyLikedUsersPaginationSuccess) {
              return current.replyId == widget.reply.id;
            }
            return false;
          },
          builder: (context, state) {
            final replyLikedUsersBloc = context.read<ReplyLikedUsersBloc>();

            if (state is ReplyLikedUsersLoading) {
              return const Center(child: CircularProgressLoading());
            } else if (state is ReplyLikedUsersError) {
              return const ErrorScreen(isFeedError: false);
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: replyLikedUsersBloc.allUsers.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.005,
                    ),
                    child: SearchField(
                      focusNode: focusNode,
                      textEditingController: textEditingController,
                      onChanged: (value) {
                        final String finalValue =
                            value.startsWith("@") ? value.substring(1) : value;
                        _debounce.onChanged(
                          onTimerEnd: () {
                            if (value.trim().isEmpty) {
                              BlocProvider.of<ReplyLikedUsersBloc>(context).add(
                                GetReplyLikedUsers(
                                  replyId: widget.reply.id,
                                  showloading: false,
                                ),
                              );
                              return;
                            }
                            BlocProvider.of<ReplyLikedUsersBloc>(context).add(
                              SearchReplyLikedUser(
                                replyId: widget.reply.id,
                                userToSearch: finalValue,
                              ),
                            );
                          },
                        );
                      },
                      isMini: true,
                      hintText: "Search liked users",
                    ),
                  );
                }

                if (index == replyLikedUsersBloc.allUsers.length + 1) {
                  return replyLikedUsersBloc.hasMore &&
                          !replyLikedUsersBloc.isSearchMode
                      ? Center(child: const CircularProgressLoading())
                      : const SizedBox.shrink();
                }

                final user = replyLikedUsersBloc.allUsers[index - 1];
                return CustomUserTile(
                  user: user,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

