import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/tab_bar.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_posts_helper.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_saved_posts_helper.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/tab_mode_enum.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/user_posts_tab.dart';
import 'package:snibbo_app/features/user/presentation/widgets/user_info_header.dart';
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
    final hasMoreUserPosts = UserPostsHelper.hasMore[widget.profileEntity.username] == true;
    final userPostsLoading = UserPostsHelper.isLoading[widget.profileEntity.username] == true;
    
    final hasMoreUserSavedPosts = UserSavedPostsHelper.hasMore[widget.profileEntity.username] == true;
    final userSavedPostsLoading = UserSavedPostsHelper.isLoading[widget.profileEntity.username] == true;

    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (tabMode == TabModeEnum.userPosts) {
        if (hasMoreUserPosts && !userPostsLoading) {
          context.read<UserPostsPaginationBloc>().add(
            LoadMoreUserPosts(username: widget.profileEntity.username),
          );
        }
      } else if (tabMode == TabModeEnum.userSavedPosts) {
        if (hasMoreUserSavedPosts && !userSavedPostsLoading) {
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
    return MultiBlocListener(
        listeners: [
          BlocListener<UserPostsPaginationBloc, UserPostsPaginationStates>(
            listenWhen: (previous, current) {
              if (current is UserPostsPaginationError ) {
               return current.username == widget.profileEntity.username;
              }return false;
            },
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
            listenWhen: (previous, current) {
              if (current is UserSavedPostsPaginationError) {
                  return current.username == widget.profileEntity.username;
              } return false;
            },
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.20),
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
          body: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                _controllerListener();
              }
              return false;
            },
            child: TabBarView(
              controller: tabController,
              children: [
                BlocBuilder<UserPostsPaginationBloc, UserPostsPaginationStates>(
                  buildWhen: (previous, current) {
                    if (current is UserPostsPaginationLoaded) {
                      return current.username == widget.profileEntity.username;
                    } else if (current is ReloadUserPostsLoading) {
                      return current.username == widget.profileEntity.username;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is ReloadUserPostsLoading) {
                      return Center(child: CircularProgressLoading());
                    }
                    return UserPostsTab(
                      isUserPosts: true,
                      posts:  UserPostsHelper.posts[widget.profileEntity.username] ?? [],
                      hasMore: UserPostsHelper.hasMore[widget.profileEntity.username] ?? false,
                      profileEntity: widget.profileEntity,
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
                    } else if (current is ReloadUserSavedLoading) {
                      return current.username == widget.profileEntity.username;
                    } else {
                      return false;
                    }
                  },
      
                  builder: (context, state) {
                    if (state is ReloadUserSavedLoading) {
                      return Center(child: CircularProgressLoading());
                    }
                    return UserPostsTab(
                      isUserPosts: false,
                      posts: UserSavedPostsHelper.posts[widget.profileEntity.username] ?? [],
                      profileEntity: widget.profileEntity,
                      hasMore: UserSavedPostsHelper.hasMore[widget.profileEntity.username] ?? false,
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
