import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_events.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@RoutePage()
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FocusNode searchNode = FocusNode();
  late ScrollController controller;
  late ExplorePostsBloc explorePostsBloc;

  void _listener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (explorePostsBloc.hasMore && !explorePostsBloc.isLoading) {
        explorePostsBloc.add(LoadMoreExplorePosts());
      }
    }
  }

  @override
  void initState() {
    explorePostsBloc = context.read<ExplorePostsBloc>();
    controller = ScrollController()..addListener(_listener);
    explorePostsBloc.add(GetPosts());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.0050),
          child: NestedScrollView(
            headerSliverBuilder:
                (context, isScrolled) => [
                  SliverAppBar(
                    title: ListTile(
                      onTap: () {
                        context.router.push(SearchUserScreenRoute());
                      },
                      minTileHeight: height * 0.04,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      dense: true,
                      leading: Icon(
                        Icons.search_rounded,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      title: Text(
                        "Search",
                        style: TextStyle(
                          color: MyColors.grey,
                          fontSize: height * 0.02,
                        ),
                      ),
                      tileColor: MyColors.searchField,
                    ),
                  ),
                ],
            body: MyRefreshBar(
              onRefresh: () async {
                 await Future.delayed(500.ms);
                              if (context.mounted) {
                                explorePostsBloc.add(GetPosts());
                              }
                
              },
              widget: BlocConsumer<ExplorePostsBloc, ExplorePostsStates>(
                listener: (context, state) {
                  if (state is ExplorePostsError) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.descrition,
                      context: context,
                      isSuccess: false,
                      isWarning: false,
                    );
                  } else if (state is ExplorePaginationError) {
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
                builder: (context, state) {
                  if (state is ExplorePostsInitial) {
                    return Center(child: CircularProgressLoading());
                  } else if (state is ExplorePostsError) {
                    return ErrorScreen(isFeedError: false,);
                  } else if (state is ExplorePostsLoading) {
                    return Center(child: CircularProgressLoading());
                  }

                  return CustomScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          bottom:
                              explorePostsBloc.hasMore
                                  ? 0
                                  : UiUtils.bottomNavBar(context: context),
                        ),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: width * 0.0050,
                          mainAxisSpacing: width * 0.0050,
                          childCount: explorePostsBloc.allPosts.length,
                          itemBuilder: (context, index) {
                            final allPosts = explorePostsBloc.allPosts;
                            return GestureDetector(
                              onTap: () {
                                context.router.push(
                                  ExplorePostsViewScreenRoute(
                                    initialIndex: index,
                                  ),
                                );
                              },
                              child: Image.network(
                                allPosts[index].postContent,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child:
                            explorePostsBloc.hasMore
                                ? Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    top: height * 0.02,
                                    bottom:
                                        UiUtils.bottomNavBar(context: context) +
                                        height * 0.02,
                                  ),
                                  child: CircularProgressLoading(),
                                )
                                : SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
