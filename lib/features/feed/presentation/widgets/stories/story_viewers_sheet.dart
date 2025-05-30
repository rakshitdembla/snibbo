import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_listtile.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/story_viewers_bloc/story_viewers_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/story_viewers_bloc/story_viewers_states.dart';
import 'package:story_view/controller/story_controller.dart';

class StoryViewersSheet {
  static void show({
    required BuildContext context,
    required bool isDark,
    required StoryController controller,
  }) async {
     MyBottomModalSheet.show(
      context: context,
      isDark: isDark,
      controller: controller,
      builder: (context) {
        return BlocBuilder<StoryViewersBloc, StoryViewersStates>(
          builder: (context, state) {
            if (state is StoryViewersErrorState) {
              return SheetHeading(
                widget: Center(
                  child: Text("Error Users"),
                ), //@ Error PlaceHolder
              );
            } else if (state is StoryViewersSuccessState) {
              final users = state.users;
              return SheetHeading(
                widget:
                    users.isEmpty
                        ? Center(child: Text("No Users"))
                        //@ No Users PlaceHolder,
                        : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            debugPrint("${user.name},${user.profilePicture}");
                            return UserListTile(
                              name: user.name,
                              profileUrl: user.profilePicture.toString(),
                              username: user.username,
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
