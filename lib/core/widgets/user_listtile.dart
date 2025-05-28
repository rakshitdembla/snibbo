import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';

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
      minTileHeight: height * 0.08,
      leading: UserStoryWidget(
        profileUrl: profileUrl,
        margins: EdgeInsets.symmetric(),
        storySize: 0.06,
        isMini: true,
        greyBorder: false,
        showBorder: false,
      ),
      title: Text(name,style: TextStyle(fontSize: width* 0.037,fontWeight: FontWeight.w600),),
      subtitle: Text("@$username",style: TextStyle(fontSize: width* 0.028,fontWeight: FontWeight.w100)),
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
