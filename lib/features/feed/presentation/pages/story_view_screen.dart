import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';
import "package:story_view/story_view.dart";

@RoutePage()
class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    List<StoryItem> storyItems = [
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
      StoryItem.pageImage(
        url:
            "https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=",
        controller: controller,
        caption: Text(
          "caption",
          style: GoogleFonts.poppins(
            color: MyColors.primary,
            fontSize: height * 0.02,
          ),
        ),
      ),
    ];
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              UserStoryWidget(
                 showBorder: true,
              greyBorder: false,
                profileUrl: MyAssets.demoUser,
                storySize: 0.05,
                showComment: false,
                showLike: false,
                isMini: true,
                margins: EdgeInsets.zero,
                
              ),
              Text(
                "rakshitdembla",
                style: TextStyle(color: MyColors.white, fontSize: width * 0.5),
              ),
            ],
          ),
        ),
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: () {
            context.router.pop();
          },
          progressPosition: ProgressPosition.top,
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
