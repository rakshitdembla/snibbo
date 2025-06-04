import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/profile_view.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? username;

  void _initialize() async {
    username = await ServicesUtils.getUsername();
    if (mounted) {
      BlocProvider.of<UserProfileBloc>(
        context,
      ).add(GetUserProfile(username: username!));
    }
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserProfileBloc, UserProfileStates>(
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
          builder: (context, state) {
            if (state is UserProfileSuccess) {
              return ProfileView(profileEntity: state.profileEntity);
            } else if (state is UserProfileError) {
              return Center(child: Text("Failed to load user profile"));
            } else {
              return Center(child: CircularProgressLoading());
            }
          },
        ),
      ),
    );
  }
}
