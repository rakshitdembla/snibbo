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
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_states.dart';

class UserFollowingsTab extends StatefulWidget {
  final String username;

  const UserFollowingsTab({super.key, required this.username});

  @override
  State<UserFollowingsTab> createState() => _UserFollowingsTabState();
}

class _UserFollowingsTabState extends State<UserFollowingsTab> {
  late ScrollController _controller;
  late UserFollowingsBloc userFollowingsBloc;
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  final SearchDebouncingHelper _debounce = SearchDebouncingHelper();

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (userFollowingsBloc.hasMore && !userFollowingsBloc.isLoading) {
        userFollowingsBloc.add(
          LoadMoreUserFollowings(username: widget.username),
        );
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<UserFollowingsBloc>(
      context,
    ).add(GetUserFollowings(username: widget.username, showLoading: true));
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    _controller = ScrollController();
    userFollowingsBloc = context.read<UserFollowingsBloc>();
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
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return MyRefreshBar(
      onRefresh: () async {
        textEditingController.clear();
        BlocProvider.of<UserFollowingsBloc>(
          context,
        ).add(GetUserFollowings(username: widget.username, showLoading: true));
      },
      widget: BlocConsumer<UserFollowingsBloc, UserFollowingsStates>(
        listenWhen: (previous, current) {
          if (current is UserFollowingsError) {
            return current.username == widget.username;
          } else if (current is UserFollowingsPaginationError) {
            return current.username == widget.username;
          }
          return false;
        },
        listener: (context, state) {
          if (state is UserFollowingsError) {
            UiUtils.showToast(
              title: state.title,
              isDark: isDark,
              description: state.descrition,
              context: context,
              isSuccess: false,
              isWarning: false,
            );
          } else if (state is UserFollowingsPaginationError) {
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
          if (current is UserFollowingsLoading) {
            return current.username == widget.username;
          } else if (current is UserFollowingsError) {
            return current.username == widget.username;
          } else if (current is UserFollowingsLoaded) {
            return current.username == widget.username;
          } else if (current is UserFollowingsPaginationSuccess) {
            return current.username == widget.username;
          }
          return false;
        },
        builder: (context, state) {
          final userFollowingsBloc = context.read<UserFollowingsBloc>();
          if (state is UserFollowingsLoading) {
            return const Center(child: CircularProgressLoading());
          } else if (state is UserFollowingsError) {
            return const ErrorScreen(isFeedError: false);
          }
          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: userFollowingsBloc.allFollowings.length + 2,
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
                            BlocProvider.of<UserFollowingsBloc>(context).add(
                              GetUserFollowings(
                                username: widget.username,
                                showLoading: false,
                              ),
                            );
                            return;
                          }
                          BlocProvider.of<UserFollowingsBloc>(context).add(
                            SearchFollowing(
                              username: widget.username,
                              userToSearch: finalValue,
                            ),
                          );
                        },
                      );
                    },
                    isMini: true,
                    hintText: "Search in followings",
                  ),
                );
              }

              if (index == userFollowingsBloc.allFollowings.length + 1) {
                return userFollowingsBloc.hasMore &&
                        !userFollowingsBloc.isSearchMode
                    ? CircularProgressLoading()
                    : SizedBox.shrink();
              }
              final user = userFollowingsBloc.allFollowings[index - 1];
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
