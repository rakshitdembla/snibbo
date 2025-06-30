import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class FeedAppBar extends StatelessWidget {
   final PersistentTabController navController;
  const FeedAppBar({super.key,required this.navController});

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return SliverAppBar(
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
                  onTap: () {
                    navController.jumpToTab(2);
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    size: width * 0.075,
                    color: isDark ? MyColors.white : MyColors.black,
                  ),
                ),
                SizedBox(width: width * 0.05),
                GestureDetector(
                  onTap: () {
                    context.router.push(ChatListScreenRoute());
                  },
                  child: Stack(
                    children: [
                      Icon(
                        Icons.send,
                        size: width * 0.075,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
