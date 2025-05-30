import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:story_view/controller/story_controller.dart';

class MyBottomModalSheet {
  static Future<void> show({
    required BuildContext context,
    required bool isDark,
    StoryController? controller,
    required WidgetBuilder builder,
  }) async{
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      isDismissible: true,
      context: context,
      builder: builder,
      useSafeArea: true
    );
    controller?.play();
  }
}
