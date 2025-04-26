import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widget/post_widget.dart';
import 'package:snibbo_app/core/widget/user_story_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: width * 0.17,
        leading: Container(
          alignment: Alignment.center,
          child: Image.asset(
            isDark ? MyAssets.whiteGhost : MyAssets.blackGhost,
            height: height * 0.09,
            width: width * 0.09,
          ),
        ),
        actions: [
          Image.asset(
            isDark ? MyAssets.postWhite : MyAssets.postBlack,
            height: height * 0.067,
            width: width * 0.067,
          ),
          SizedBox(width: width * 0.04),

          Stack(
            children: [
              Image.asset(
                isDark ? MyAssets.chatBubbleWhite : MyAssets.chatBubble,
                height: height * 0.077,
                width: width * 0.077,
              ),
              Positioned(
                top: height * 0.01,
                right: width * 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: width * 0.02,
                  child: Text(
                    "9+",
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: width * 0.03),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * 0.15,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserStoryWidget(
                        outsidePadding : EdgeInsets.all(width * 0.007),insidePadding : EdgeInsets.all(width * 0.005),
                        margins: EdgeInsets.fromLTRB(
                          width * 0.023,
                          height * 0.015,
                          width * 0.023,
                          height * 0.004,
                        ),
                        height: height * 0.10,
                        width: width * 0.20,
                      ),

                      Text(
                        "rakshit_dembla...",
                        style: TextStyle(fontSize: width * 0.024),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PostWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
