import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_profile_pic_widget.dart';

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
    return ListTile(
      leading: UserProfilePicWidget(
        profileUrl: profileUrl,
        margins: EdgeInsets.symmetric(),
        storySize: width * 0.02,
        isMini: true,
        greyBorder: true,
        showBorder: true,
      ),
      title: Text(name),
      subtitle: Text(username),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert_outlined,
          color: isDark ? MyColors.white : MyColors.black,
        ),
      ),
    );
  }
}
