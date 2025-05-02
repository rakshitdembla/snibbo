import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/post_widget.dart';

@RoutePage()
class PostsViewScreen extends StatelessWidget {
  final String appbarTitle;
  final List posts;
  const PostsViewScreen({
    super.key,
    required this.appbarTitle,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
        final height = UiUtils.screenHeight(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, title: Text(appbarTitle)),
      body: Padding(
        padding: EdgeInsets.only(bottom: height * 0.02,top: 0 ),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder:
              (context, index) => PostWidget(postContentUrl: posts[index]),
        ),
      ),
    );
  }
}
