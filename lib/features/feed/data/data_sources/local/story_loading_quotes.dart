class StoryLoadingQuote {
  final String assetPath;
  final String quoteTemplate;

  StoryLoadingQuote({required this.assetPath, required this.quoteTemplate});

 static List<StoryLoadingQuote> getQuote(String username) {
    List<StoryLoadingQuote> storyLoadingQuotes = [
      StoryLoadingQuote(
        assetPath: "assets/lottie/cat.json",
        quoteTemplate: "@$username is making us wait… again 🙄",
      ),
      StoryLoadingQuote(
        assetPath: "assets/lottie/netflix.json",
        quoteTemplate: "Still loading @$username's overdramatic life 🎭",
      ),
      StoryLoadingQuote(
        assetPath: "assets/lottie/please_wait.json",
        quoteTemplate: "Please wait… @$username is feeling important ⏳",
      ),
      StoryLoadingQuote(
        assetPath: "assets/lottie/servers.json",
        quoteTemplate: "@$username's secrets are heavier than our servers 🧠",
      ),
      StoryLoadingQuote(
        assetPath: "assets/lottie/cat.json",
        quoteTemplate: "Checking if @$username even has a life to load 🧐",
      ),
      StoryLoadingQuote(
        assetPath: "assets/lottie/snail_walk.json",
        quoteTemplate:
            "@$username's story is taking longer than their replies 💤",
      ),
      StoryLoadingQuote(
        assetPath:
            "assets/lottie/construction.json",
        quoteTemplate: "Plot under construction… blame @$username 🚧",
      ),
      StoryLoadingQuote(
        assetPath:
            "assets/lottie/movie.json",
        quoteTemplate: "Should've brought snacks. This might take a while 🍿",
      ),
    ];

    return storyLoadingQuotes;
  }
}
