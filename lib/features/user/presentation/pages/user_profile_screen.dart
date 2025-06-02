import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/tab_bar.dart';
import 'package:snibbo_app/features/user/presentation/widgets/profile_view.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/pages/tabs/user_posts_tab.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import '../../../settings/presentation/bloc/theme_bloc.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  final String profileUrl;
  final bool showStoryBorder;
  final bool isStoryViewed;
  final int posts;
  final String bio;
  final int followers;
  final int followings;
  final String name;
  final String username;
  final bool isMyProfile;
  const UserProfileScreen({
    super.key,
    required this.profileUrl,
    required this.isStoryViewed,
    required this.showStoryBorder,
    required this.name,
    required this.bio,
    required this.followers,
    required this.followings,
    required this.posts,
    required this.isMyProfile,
    required this.username,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "@${widget.username}",
            style: TextStyle(fontWeight: FontWeight.w700),
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
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: ProfileView(
                      profileUrl: widget.profileUrl,
                      isStoryViewed: widget.isStoryViewed,
                      showStoryBorder: widget.showStoryBorder,
                      name: widget.name,
                      bio: widget.bio,
                      followers: widget.followers,
                      followings: widget.followings,
                      posts: widget.posts,
                      isMyProfile: widget.isMyProfile,
                      username: widget.username,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _TabBarDelegate(
                    TabBarWidget(
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Icon(
                            Icons.grid_view,
                            size: width * 0.07,
                            color: isDark ? MyColors.white : MyColors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Icon(
                            Icons.bookmark_add_outlined,
                            size: width * 0.07,
                            color: isDark ? MyColors.white : MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          body: TabBarView(children: [UserPostsTab(), UserPostsTab()]),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => 37.5;
  @override
  double get maxExtent => 37.5;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return tabBar;
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) {
    return false;
  }
}
