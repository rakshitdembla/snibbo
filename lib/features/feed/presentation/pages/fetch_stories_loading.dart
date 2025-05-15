import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/feed/data/data_sources/local/story_loading_quotes.dart';
import 'dart:math';

@RoutePage()
class FetchStoriesLoading extends StatefulWidget {
  final String username;
  const FetchStoriesLoading({super.key, required this.username});

  @override
  State<FetchStoriesLoading> createState() => _FetchStoriesLoadingState();
}

class _FetchStoriesLoadingState extends State<FetchStoriesLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final List<StoryLoadingQuote> quotes = StoryLoadingQuote.getQuote(
      widget.username,
    );
    final StoryLoadingQuote quote = quotes[Random().nextInt(quotes.length)];

    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(quote.assetPath),
            Flexible(
              child: Text(
                quote.quoteTemplate,
                style: TextStyle(
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
