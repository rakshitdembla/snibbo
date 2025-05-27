import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_profile_pic_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/icon_with_text.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import "package:story_view/story_view.dart";

@RoutePage()
class StoryViewScreen extends StatefulWidget {
  final List<StoryEntitiy> stories;
  final String username;
  final String profilePicture;
  const StoryViewScreen({
    super.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  StoryController controller = StoryController();
  late List<StoryItem> storyItems;
  int storyIndex = 0;

  @override
  void initState() {
    storyItems =
        widget.stories
            .map(
              (story) => StoryItem.pageImage(
                loadingWidget: CircularProgressLoading(),
                // errorWidget: ,
                duration: Duration(seconds: 15),
                url: story.storyContent,
                controller: controller,
              ),
            )
            .toList();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * 0.93,
              child: InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                  child: StoryView(
                    storyItems: storyItems,
                    controller: controller,
                    onComplete: () {
                      context.router.pop();
                    },
                    onStoryShow: (storyItem, index) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          storyIndex = index;
                        });
                      });
                    },
                    progressPosition: ProgressPosition.top,
                    onVerticalSwipeComplete: (direction) {
                      if (direction == Direction.down) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: width * 0.04,
            top: height * 0.09,
            child: Row(
              children: [
                UserProfilePicWidget(
                  showBorder: false,
                  greyBorder: false,
                  profileUrl: widget.profilePicture,
                  storySize: 0.055,
                  isMini: true,
                  margins: EdgeInsets.zero,
                ),
                SizedBox(width: width * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: width * 0.04,
                      ),
                    ),
                    Text(
                      ServicesUtils.toTimeAgo(
                        widget.stories[storyIndex].createdAt,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: MyColors.grey,
                        fontSize: width * 0.025,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: height * 0.01,
            child: SizedBox(
              width: width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    IconWithText(
                      height: height,
                      icon: Icons.group_outlined,
                      isDark: isDark,
                      text: "Activity",
                      onTap: () {},
                    ),
                    Spacer(),
                    IconWithText(
                      height: height,
                      icon: Icons.delete_outline,
                      isDark: isDark,
                      text: "Delete",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
