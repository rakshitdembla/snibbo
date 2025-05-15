class CreateStoryModel {
    String storyContent;
    String contentType;

    CreateStoryModel({
        required this.storyContent,
        required this.contentType,
    });

    Map<String, dynamic> toJson() => {
        "storyContent": storyContent,
        "contentType": contentType,
    };
}
