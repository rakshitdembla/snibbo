import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class FeedPostsList extends StatefulWidget {
  final ScrollController controller;
  const FeedPostsList({super.key, required this.controller});

  @override
  State<FeedPostsList> createState() => _FeedPostsListState();
}

class _FeedPostsListState extends State<FeedPostsList> {
  late PostPaginationBloc paginationBloc;
  String? username;

  Future<void> _getUsername() async {
    username = await ServicesUtils.getUsername();
    setState(() {});
  }

  void _controllerListener() {
    final hasMore =
        paginationBloc.hasMoreAllPosts || paginationBloc.hasMoreFollowingPosts;

    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent) {
      if (hasMore && !paginationBloc.isLoading) {
        context.read<PostPaginationBloc>().add(LoadMorePosts());
      }
    }
  }

  @override
  void initState() {
    _getUsername();
    paginationBloc = context.read<PostPaginationBloc>();
    widget.controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (username == null) {
      return SliverToBoxAdapter(child: const SizedBox.shrink());
    }
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);

    return BlocConsumer<PostPaginationBloc, PostPaginationStates>(
      listener: (context, state) {
        if (state is PostPaginationError) {
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
      builder: (context, state) {
        if (state is RefreshFeedPosts) {
          return Center(child: CircularProgressLoading());
        }
        final hasMore =
            paginationBloc.hasMoreAllPosts ||
            paginationBloc.hasMoreFollowingPosts;

        return SliverPadding(
          padding: EdgeInsets.only(
            bottom: UiUtils.bottomNavBar(context: context),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: paginationBloc.allposts.length + 1,
              (context, index) {
                if (index == paginationBloc.allposts.length) {
                  return hasMore
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Center(child: CircularProgressLoading()),
                      )
                      : const SizedBox.shrink();
                } else {
                  final post = paginationBloc.allposts[index];
                  return PostWidget(key: ValueKey(post.id), postEntity: post);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
