import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/network/helpers/search_debouncing.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/explore/presentation/widgets/search_field.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_states.dart';

class UserFollowersTab extends StatefulWidget {
  final String username;

  const UserFollowersTab({super.key, required this.username});

  @override
  State<UserFollowersTab> createState() => _UserFollowersTabState();
}

class _UserFollowersTabState extends State<UserFollowersTab> {
  late ScrollController _controller;
  late UserFollowersBloc userFollowersBloc;
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  final SearchDebouncingHelper _debounce = SearchDebouncingHelper();

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (userFollowersBloc.hasMore && !userFollowersBloc.isLoading) {
        userFollowersBloc.add(LoadMoreUserFollowers(username: widget.username));
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<UserFollowersBloc>(
      context,
    ).add(GetUserFollowers(username: widget.username, showLoading: true));
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    _controller = ScrollController();
    userFollowersBloc = context.read<UserFollowersBloc>();
    _controller.addListener(_listener);
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
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    return MyRefreshBar(
      onRefresh: () async {
        textEditingController.clear();
        BlocProvider.of<UserFollowersBloc>(
          context,
        ).add(GetUserFollowers(username: widget.username, showLoading: true));
      },
      widget: BlocConsumer<UserFollowersBloc, UserFollowersStates>(
        listenWhen: (previous, current) {
          if (current is UserFollowersError) {
            return current.username == widget.username;
          } else if (current is UserFollowersPaginationError) {
            return current.username == widget.username;
          }
          return false;
        },
        listener: (context, state) {
          if (state is UserFollowersError) {
            UiUtils.showToast(
              title: state.title,
              isDark: isDark,
              description: state.descrition,
              context: context,
              isSuccess: false,
              isWarning: false,
            );
          } else if (state is UserFollowersPaginationError) {
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
          if (current is UserFollowersLoading) {
            return current.username == widget.username;
          } else if (current is UserFollowersError) {
            return current.username == widget.username;
          } else if (current is UserFollowersLoaded) {
            return current.username == widget.username;
          } else if (current is UserFollowersPaginationSuccess) {
            return current.username == widget.username;
          }
          return false;
        },
        builder: (context, state) {
          final userFollowersBloc = context.read<UserFollowersBloc>();
          if (state is UserFollowersLoading) {
            return const Center(child: CircularProgressLoading());
          } else if (state is UserFollowersError) {
            return const ErrorScreen(isFeedError: false);
          }
          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: userFollowersBloc.allFollowers.length + 2,
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
                            BlocProvider.of<UserFollowersBloc>(context).add(
                              GetUserFollowers(
                                username: widget.username,
                                showLoading: false,
                              ),
                            );
                            return;
                          }
                          BlocProvider.of<UserFollowersBloc>(context).add(
                            SearchFollower(
                              username: widget.username,
                              userToSearch: finalValue,
                            ),
                          );
                        },
                      );
                    },
                    isMini: true,
                    hintText: "Search in followers",
                  ),
                );
              }

              if (index == userFollowersBloc.allFollowers.length + 1) {
                return userFollowersBloc.hasMore && !userFollowersBloc.isSearchMode
                    ? Center(child: CircularProgressLoading())
                    : SizedBox.shrink();
              }

              final user = userFollowersBloc.allFollowers[index - 1];

              return CustomUserTile(
                user: user,
              );
            },
          );
        },
      ),
    );
  }
}
