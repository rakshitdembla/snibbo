import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_listtile.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_states.dart';
import 'package:story_view/controller/story_controller.dart';

class StoryViewersSheet {
  static void show({
    required BuildContext context,
    required bool isDark,
    required StoryController controller,
  }) async {
     MyBottomModalSheet.show(
      isScrollControlled: false,
      context: context,
      isDark: isDark,
      controller: controller,
      builder: (context) {
        final height = UiUtils.screenHeight(context);
        return BlocBuilder<StoryViewersBloc, StoryViewersStates>(
          builder: (context, state) {
            if (state is StoryViewersErrorState) {
              return SheetHeading(
                widget: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: Center(
                    child: Lottie.asset(MyAssets.cat404, height: height * 0.1),
                  ),
                ), 
              );
            } else if (state is StoryViewersSuccessState) {
              final users = state.users;
              return SheetHeading(
                widget:
                    users.isEmpty
                        ? Padding(
                          padding: EdgeInsets.only(bottom: height * 0.05),
                          child: Center(child: Text("No Views Yet")))
                        : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return UserListTile(
                              user: user,
                              isStatic: true,
                              isDark: isDark,
                            );
                          },
                        ),
              );
            } else {
              return SheetHeading(
                widget: Center(child: CircularProgressLoading()),
              );
            }
          },
        );
      },
    );
  }
}

class SheetHeading extends StatelessWidget {
  final Widget widget;
  const SheetHeading({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return SizedBox(
      height: height * 0.5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: height * 0.06,
          title: Text(
            "Story Views",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.042,
            ),
          ),
        ),
        body: widget,
      ),
    );
  }
}
