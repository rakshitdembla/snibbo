import 'package:flutter/material.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, title: Text("Activity")),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            minTileHeight: height * 0.05,
            leading: UserStoryWidget(
              isComment: true,
              profileUrl: MyAssets.demoUser,
              height: height * 0.1,
              margins: EdgeInsets.zero,
              width: width * 0.14,
              insidePadding: EdgeInsets.all(width * 0.004),
              outsidePadding: EdgeInsets.all(width * 0.004),
            ),
            title: Text(
              "@rakshitdembla started following you, go and follow them back",
              style: TextStyle(fontSize: height * 0.0150),
            ),
            trailing: Image.asset(MyAssets.gradient),
          );
        },
      ),
    );
  }
}
