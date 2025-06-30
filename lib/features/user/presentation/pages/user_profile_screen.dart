import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/profile_view.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  final String? username;
  final bool? isMyProfile;

  const UserProfileScreen({super.key, this.username, this.isMyProfile});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String? username;
  void getUserProfile() async {
    if (widget.isMyProfile == true) {
      username = await ServicesUtils.getUsername();
    } else {
      username = widget.username;
    }

    if (mounted) {
      BlocProvider.of<UserProfileBloc>(
        context,
      ).add(GetUserProfile(username: username!));
    }
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // UserProfileCleanup.call(username: widget.username);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "@${widget.username}",
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: BlocConsumer<UserProfileBloc, UserProfileStates>(
            listenWhen: (previous, current) {
              if (current is UserProfileError) {
                return current.username == widget.username;
              } else if (current is UserProfileSuccess) {
                return current.username == widget.username;
              }
              return false;
            },
            listener: (context, state) {
              if (state is UserProfileError) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              } else if (state is UserProfileSuccess) {
                //Initialize Paginations for User Posts & User Saved Posts
                BlocProvider.of<UserPostsPaginationBloc>(context).add(
                  InitializeUserPosts(
                    initialPosts: state.userPosts,
                    username: username!,
                  ),
                );

                BlocProvider.of<UserSavedPostsPaginationBloc>(context).add(
                  InitializeUserSavedPosts(
                    initialPosts: state.userSavedPosts,
                    username: username!,
                  ),
                );
              }
            },
            buildWhen: (previous, current) {
              if (current is UserProfileSuccess) {
                return current.username == widget.username;
              } else if (current is UserProfileLoading) {
                return current.username == widget.username;
              } else if (current is UserProfileError) {
                return current.username == widget.username;
              }
              return false;
            },
            builder: (context, state) {
              if (state is UserProfileSuccess) {
                return ProfileView(profileEntity: state.profileEntity);
              } else if (state is UserProfileError) {
                return const Center(child: Text("Failed to load user profile"));
              } else {
                return const Center(child: CircularProgressLoading());
              }
            },
          ),
        ),
      ),
    );
  }
}
