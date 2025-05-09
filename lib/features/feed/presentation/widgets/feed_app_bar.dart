import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class FeedAppBar extends StatelessWidget {
  const FeedAppBar({super.key});

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
    );
  }
}
