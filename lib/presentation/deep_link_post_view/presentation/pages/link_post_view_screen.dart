import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

@RoutePage()
class LinkPostViewScreen extends StatelessWidget {
  final String postId;
  const LinkPostViewScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final demoPost = PostEntity(
      id: "demo_post_001",
      userId: UserEntity(
        username: "john_doe",
        name: "John Doe",
        isVerified: true,
      ),
      postContent: "This is a demo post content for testing UI.",
      likesLength: 123,
      commentsLength: 45,
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
      updatedAt: DateTime.now(),
      isLikedByMe: false,
      isSavedByMe: false,
      isMyPost: false,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Shared Post")),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: PostWidget(postEntity: demoPost)),
      ),
    );
  }
}
