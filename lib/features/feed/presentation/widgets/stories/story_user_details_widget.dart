import 'package:flutter/cupertino.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

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
    return  Row(
        children: [
          UserCircularProfileWidget(
            showBorder: false,
            greyBorder: false,
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
                overflow: TextOverflow.ellipsis,
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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: const Color.fromARGB(255, 172, 171, 171),
                  fontSize: width * 0.025,
                ),
              ),
            ],
          ),
        ],
      );
    
  }
}
