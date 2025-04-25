import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Scaffold(
      appBar: AppBar(),

    );
  }
}