import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/post_widget.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/test_list.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final testList = TestList.test();
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.08,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Row(
                      children: [
                        Image.asset(
                          isDark ? MyAssets.whiteGhost : MyAssets.blackGhost,
                          height: height * 0.09,
                          width: width * 0.09,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.add_box_outlined,
                            size: width * 0.075,
                            color: isDark ? MyColors.white : MyColors.black,
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                        GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Icon(
                                Icons.send,
                                size: width * 0.075,
                                color: isDark ? MyColors.white : MyColors.black,
                              ),
                              Positioned(
                                top: height * 0,
                                right: width * 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: width * 0.018,
                                  child: Text(
                                    "9+",
                                    style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: width * 0.018,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.14,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: testList.length,
                  itemBuilder: (context, index) {
                    debugPrint("Story builds $index");
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? width * 0.015 : 0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserStoryWidget(
                            profileUrl: testList[index],
                            outsidePadding: EdgeInsets.all(width * 0.007),
                            insidePadding: EdgeInsets.all(width * 0.005),
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
                            style: TextStyle(fontSize: height * 0.012),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: testList.length,
                (context, index) {
                  debugPrint("Post builds $index");
                  return PostWidget(postContentUrl: testList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
