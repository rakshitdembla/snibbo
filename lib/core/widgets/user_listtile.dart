import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserListTile extends StatelessWidget {
  final String profileUrl;
  final String name;
  final String username;
  final bool isDark;
  const UserListTile({
    super.key,
    required this.name,
    required this.profileUrl,
    required this.username,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return ListTile(
      onTap: () {
        context.router.push(
          UserProfileScreenRoute(
            username: username,
            onPopRefreshUsername: null,
          ),
        );
      },
      minTileHeight: height * 0.08,
      dense: false,
      leading: UserCircularProfileWidget(
        profileUrl: profileUrl,
        margins: EdgeInsets.symmetric(),
        storySize: 0.06,
        greyBorder: false,
        showBorder: false,
      ),
      title: Text(
        username,
        style: TextStyle(
          fontSize: width * 0.038,
          fontWeight: FontWeight.w600,
          fontFamily: "poppinsBold",
        ),
      ),
      subtitle: Text(
        name,
        style: TextStyle(fontSize: width * 0.028, fontWeight: FontWeight.w100),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Padding(
          padding: EdgeInsets.only(left: width * 0.1),
          child: Icon(
            Icons.more_vert_outlined,
            color: isDark ? MyColors.white : MyColors.black,
          ),
        ),
      ),
    );
  }
}
