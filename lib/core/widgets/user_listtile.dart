import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserListTile extends StatelessWidget {
  final UserEntity user;
  final bool isDark;
  final bool isStatic;
  const UserListTile({super.key, required this.user, required this.isDark,required this.isStatic});

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return ListTile(
      onTap: () {
        context.router.push(
          UserProfileScreenRoute(
            username: user.username,
            onPopRefreshUsername: null,
          ),
        );
      },
      minTileHeight: height * 0.08,
      dense: false,
      leading: UserCircularProfileWidget(
        isStatic: isStatic,
        username: user.username,
        profileUrl: user.profilePicture,
        margins: EdgeInsets.symmetric(),
        storySize: 0.06,
        isAllStoriesViewed: user.isAllStoriesViewed,
        hasActiveStories: user.hasActiveStories,
      ),
      title: Text(
        user.username,
        style: TextStyle(
          fontSize: width * 0.038,
          fontWeight: FontWeight.w600,
          fontFamily: MyFonts.assetsFontFamily(),
        ),
      ),
      subtitle: Text(
        user.name,
        style: TextStyle(fontSize: width * 0.028, fontWeight: FontWeight.w100),
      ),
      trailing: PopupMenuButton<String>(
        color: isDark ? MyColors.darkPrimary : MyColors.primary,
        onSelected: (String value) {
          debugPrint("You selected $value");
        },
        icon: Icon(
          Icons.more_vert_outlined,
          color: isDark ? MyColors.white : MyColors.black,
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'report',
              child: Text(
                'Report',
                style: TextStyle(
                  color: isDark ? MyColors.white : MyColors.black,
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
