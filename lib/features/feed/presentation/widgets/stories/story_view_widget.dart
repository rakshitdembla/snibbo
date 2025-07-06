import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewWidget extends StatefulWidget {
  final List<StoryItem> storyItems;
  final StoryController controller;
  final Function(StoryItem, int)? onStoryShow;
  final Function()? onComplete;
  final Function(Direction?)? onVerticalSwipeComplete;
  const StoryViewWidget({
    super.key,
    required this.storyItems,
    required this.controller,
    required this.onStoryShow,
    required this.onComplete,
    required this.onVerticalSwipeComplete
  });

  @override
  State<StoryViewWidget> createState() => _StoryViewWidgetState();
}

class _StoryViewWidgetState extends State<StoryViewWidget> {
  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: height * 0.93,
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
            child: StoryView(
              storyItems: widget.storyItems,
              controller: widget.controller,
              indicatorHeight: IndicatorHeight.small,
              onComplete: widget.onComplete,
              onStoryShow: widget.onStoryShow,
              progressPosition: ProgressPosition.top,
              indicatorOuterPadding: EdgeInsetsGeometry.only(
                bottom: 0,
                left: width * 0.01,
                right: width * 0.01,
              ),
              onVerticalSwipeComplete: widget.onVerticalSwipeComplete ,
            ),
          ),
        ),
      ),
    );
  }
}