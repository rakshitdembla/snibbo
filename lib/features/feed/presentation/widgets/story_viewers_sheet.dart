import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_listtile.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class StoryViewersSheet {
  static void show({
    required BuildContext context,
    required bool isDark,
    required List<UserEntity> usersList,
  }) {
    final height = UiUtils.screenHeight(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      ),
      isDismissible: true,
      builder: (context) {
        return SizedBox(
          height: height * 0.6,
          child:
              usersList.isEmpty
                  ? Center(child: Text("No Users")) //@ No Users PlaceHolder
                  : ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, index) {
                      final user = usersList[index];
                      return UserListTile(
                        name: user.name,
                        profileUrl: user.profilePicture.toString(),
                        username: user.username,
                        isDark: isDark,
                      );
                    },
                  ),
        );
      },
    );
  }
}
