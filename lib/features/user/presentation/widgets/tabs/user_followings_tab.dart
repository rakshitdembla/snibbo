import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
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
    ).add(GetUserFollowings(username: widget.username));
    _controller = ScrollController();
    userFollowingsBloc = context.read<UserFollowingsBloc>();
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
        BlocProvider.of<UserFollowingsBloc>(
          context,
        ).add(GetUserFollowings(username: widget.username));
      },
      widget: BlocConsumer<UserFollowingsBloc, UserFollowingsStates>(
        listenWhen: (previous, current) {
          if (current is UserFollowingsError) {
            return current.username == widget.username;
          } else if (current is UserFollowingsPaginationError) {
             return current.username == widget.username;
          } return false;
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
          if (current is UserFollowingsLoading ) {
            return current.username == widget.username;
          } else if (current is UserFollowingsError) {
             return current.username == widget.username;
          } else if (current is UserFollowingsLoaded) {
             return current.username == widget.username;
        } else if (current is UserFollowingsPaginationSuccess) {
           return current.username == widget.username;
        } return false;
        },
        builder: (context, state) {
          final userFollowingsBloc = context.read<UserFollowingsBloc>();
          if (state is UserFollowingsLoading) {
            return Center(child: CircularProgressLoading());
          } else if (state is UserFollowingsError) {
            return Center(child: Text("Something went wrong"));
          }
          return userFollowingsBloc.allFollowings.isEmpty
              ? Center(child: Text("No Followings"))
              : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: userFollowingsBloc.allFollowings.length + 1,
                itemBuilder: (context, index) {
                  if (index == userFollowingsBloc.allFollowings.length) {
                    return userFollowingsBloc.hasMore
                        ? CircularProgressLoading()
                        : SizedBox.shrink();
                  }
                  final user = userFollowingsBloc.allFollowings[index];
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
