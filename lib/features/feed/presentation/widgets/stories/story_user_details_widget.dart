import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class StoryUserDetailsWidget extends StatelessWidget {
  final List<StoryEntitiy>? stories;
  final String profilePicture;
  final String username;
  final int? storyIndex;
  const StoryUserDetailsWidget({
    super.key,
    required this.profilePicture,
    this.stories,
    this.storyIndex,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return GestureDetector(
      onTap: () {
        context.router.push(
          UserProfileScreenRoute(
            username: username,
          ),
        );
      },
      child: Row(
        children: [
          UserCircularProfileWidget(
            isStatic: true,
            username: username,
            isAllStoriesViewed: false,
            hasActiveStories: false,
            profileUrl: profilePicture,
            storySize: 0.045,

            margins: EdgeInsets.zero,
          ),
          SizedBox(width: width * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                maxLines: 1,
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                stories != null && storyIndex != null
                    ? ServicesUtils.toTimeAgo(stories![storyIndex!].createdAt)
                    : "Loading stories...",
                maxLines: 1,
                style: TextStyle(
                  color: const Color.fromARGB(255, 172, 171, 171),
                  fontSize: width * 0.025,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
