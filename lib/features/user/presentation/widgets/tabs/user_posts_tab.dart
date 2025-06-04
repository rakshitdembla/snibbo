import 'package:flutter/material.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

class UserPostsTab extends StatefulWidget {
  final List<PostEntity> posts;
  final bool hasMore;

  const UserPostsTab({super.key, required this.posts, required this.hasMore});

  @override
  State<UserPostsTab> createState() => _UserPostsTabState();
}

class _UserPostsTabState extends State<UserPostsTab> {
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: height * 0.0020),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: width * 0.0050,
              mainAxisSpacing: width * 0.0050,
              crossAxisCount: 3,
              childAspectRatio: width / (height / 2.1),
            ),

            delegate: SliverChildBuilderDelegate(
              childCount: widget.posts.length,
              (context, index) {
                return Image.network(
                  widget.posts[index].postContent,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  ) {
                    return UiUtils.showShimmerBuilder(
                      wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                      frame: frame,
                      child: child,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(MyAssets.profilePictureHolder);
                  },
                );
              },
            ),
          ),
        ),

        SliverToBoxAdapter(
          child:
              widget.hasMore
                  ? Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.02,
                      bottom:
                          UiUtils.bottomNavBar(context: context) +
                          height * 0.02,
                    ),
                    child: CircularProgressLoading(),
                  )
                  : SizedBox(height: UiUtils.bottomNavBar(context: context)),
        ),
      ],
    );
  }
}
