import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
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
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
    final String? onPopRefreshUsername;
  const ProfileScreen({super.key,required this.onPopRefreshUsername
});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String? username;

  void initialize() async {
    username = await ServicesUtils.getUsername();
    if (mounted && username != null) {
      BlocProvider.of<UserProfileBloc>(
        context,
      ).add(GetUserProfile(username: username!));
    }
    setState(() {});
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    return
 username == null
          ? Center(child: Center(child: CircularProgressLoading()))
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "@$username",
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.router.push(SettingsScreenRoute());
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      size: width * 0.065,
                      color: isDark ? MyColors.primary : MyColors.darkPrimary,
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: BlocConsumer<UserProfileBloc, UserProfileStates>(
                              listenWhen: (previous, current) {
              if (current is UserProfileError) {
              return  current.username == username;
              } else if (current is UserProfileSuccess) {
              return  current.username == username;
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
               return current.username == username;
              } else if (current is UserProfileLoading) {
               return current.username == username;
              } else if (current is UserProfileError) {
              return  current.username == username;
              }
              return false;
            },
                  builder: (context, state) {
                    if (state is UserProfileSuccess) {
                      return ProfileView(profileEntity: state.profileEntity,onPopRefreshUsername: widget.onPopRefreshUsername,);
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
