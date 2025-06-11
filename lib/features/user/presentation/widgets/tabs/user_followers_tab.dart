import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
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
    ).add(GetUserFollowers(username: widget.username));
    _controller = ScrollController();
    userFollowersBloc = context.read<UserFollowersBloc>();
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return MyRefreshBar(
      onRefresh: () async {
        BlocProvider.of<UserFollowersBloc>(
          context,
        ).add(GetUserFollowers(username: widget.username));
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
            return Center(child: CircularProgressLoading());
          } else if (state is UserFollowersError) {
            return Center(child: Text("Something went wrong"));
          }
          return userFollowersBloc.allFollowers.isEmpty
              ? Center(child: Text("No Followers"))
              : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: userFollowersBloc.allFollowers.length + 1,
                itemBuilder: (context, index) {
                  if (index == userFollowersBloc.allFollowers.length) {
                    return userFollowersBloc.hasMore
                        ? CircularProgressLoading()
                        : SizedBox.shrink();
                  }
                  final user = userFollowersBloc.allFollowers[index];
                  return CustomUserTile(
                    user: user,
                    onPopRefreshUsername: widget.username,
                  );
                },
              );
        },
      ),
    );
  }
}
