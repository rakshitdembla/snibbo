import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/test_list.dart';

class UserPostsTab extends StatelessWidget {
   UserPostsTab({super.key});
  final testList = TestList.test();
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.only(top: height * 0.0020),
      child: GridView.builder(
        itemCount: testList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: width * 0.0050,
          mainAxisSpacing: width * 0.0050,
          crossAxisCount: 3,
          childAspectRatio: width / (height / 2),
        ),
        itemBuilder: (context, index) {
          debugPrint("$index");
          return Image.asset(testList[index], fit: BoxFit.cover);
        },
      ),
    );
  }
}
