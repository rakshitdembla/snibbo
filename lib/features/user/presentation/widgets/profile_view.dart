import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/tab_bar.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/tab_mode_enum.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/user_posts_tab.dart';
import 'package:snibbo_app/features/user/presentation/widgets/user_info_header.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import '../../../settings/presentation/bloc/theme_bloc.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  final ProfileEntity profileEntity;
  const ProfileView({super.key, required this.profileEntity});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  ScrollController controller = ScrollController();
  late UserPostsPaginationBloc userPostsBloc;
  late UserSavedPostsPaginationBloc userSavedPostsBloc;
  late TabModeEnum tabMode;
  late TabController tabController;

  void _controllerListener() {
    final hasMoreUserPosts = userPostsBloc.hasMore;
    final hasMoreSavedPosts = userSavedPostsBloc.hasMore;

 {
      if (tabMode == TabModeEnum.userPosts) {
        if (hasMoreUserPosts && !userPostsBloc.isLoading) {
          context.read<UserPostsPaginationBloc>().add(
            LoadMoreUserPosts(username: widget.profileEntity.username),
          );
        }
      } else if (tabMode == TabModeEnum.userSavedPosts) {
        debugPrint("tried to trigger event but maybe is loading");
        if (hasMoreSavedPosts && !userSavedPostsBloc.isLoading) {
          context.read<UserSavedPostsPaginationBloc>().add(
            LoadMoreSavedPosts(username: widget.profileEntity.username),
          );
        }
      }
    }
  }

  @override
  void initState() {
    userPostsBloc = context.read<UserPostsPaginationBloc>();
    userSavedPostsBloc = context.read<UserSavedPostsPaginationBloc>();

    tabMode = TabModeEnum.userPosts;
    controller.addListener(_controllerListener);

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!mounted) {
        return;
      }
      setState(() {
        tabMode =
            tabController.index == 0
                ? TabModeEnum.userPosts
                : TabModeEnum.userSavedPosts;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "@${widget.profileEntity.username}",
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserPostsPaginationBloc, UserPostsPaginationStates>(
            listener: (context, state) {
              if (state is UserPostsPaginationError) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              }
            },
          ),
          BlocListener<
            UserSavedPostsPaginationBloc,
            UserSavedPostsPaginationStates
          >(
            listener: (context, state) {
              if (state is UserSavedPostsPaginationError) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              }
            },
          ),
        ],
        child: NestedScrollView(
          controller: controller,
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: UserInfoHeader(profileEntity: widget.profileEntity),
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _TabBarDelegate(
                    TabBarWidget(
                      tabcontroller: tabController,
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
          body: TabBarView(
            controller: tabController,
            children: [
              BlocBuilder<UserPostsPaginationBloc, UserPostsPaginationStates>(
                buildWhen: (previous, current) {
                  if (current is UserPostsPaginationLoaded) {
                    return current.username == widget.profileEntity.username;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _controllerListener();
                  });

                  return UserPostsTab(
                    posts: userPostsBloc.allUserPosts,
                    hasMore: userPostsBloc.hasMore,
                  );
                },
              ),
              BlocBuilder<
                UserSavedPostsPaginationBloc,
                UserSavedPostsPaginationStates
              >(
                buildWhen: (previous, current) {
                  if (current is UserSavedPostsPaginationLoaded) {
                    return current.username == widget.profileEntity.username;
                  } else {
                    return false;
                  }
                },

                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _controllerListener();
                  });
                  return UserPostsTab(
                    posts: userSavedPostsBloc.allSavedPosts,
                    hasMore: userSavedPostsBloc.hasMore,
                  );
                },
              ),
            ],
          ),
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
