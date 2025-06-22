class ProfileEntity {
    String username;
    String name;
    String? profilePicture;
    String bio;
    bool isVerified;
    DateTime? lastSeen;
    bool isOnline;
    DateTime createdAt;
    int posts;
    int userFollowers;
    int userFollowing;
    bool hasActiveStories;
    bool viewedAllStories;
    bool isFollowedByMe;
    bool isMyProfile;

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
        required this.isFollowedByMe,
        required this.isMyProfile
    });}