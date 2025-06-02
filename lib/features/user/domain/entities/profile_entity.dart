class ProfileEntity {
    String username;
    String name;
    String profilePicture;
    String bio;
    bool isVerified;
    dynamic lastSeen;
    bool isOnline;
    DateTime createdAt;
    int posts;
    int userFollowers;
    int userFollowing;
    bool hasActiveStories;
    bool viewedAllStories;
    bool isFollowedByMe;

    ProfileEntity({
        required this.username,
        required this.name,
        required this.profilePicture,
        required this.bio,
        required this.isVerified,
        required this.lastSeen,
        required this.isOnline,
        required this.createdAt,
        required this.posts,
        required this.userFollowers,
        required this.userFollowing,
        required this.hasActiveStories,
        required this.viewedAllStories,
        required this.isFollowedByMe
    });}