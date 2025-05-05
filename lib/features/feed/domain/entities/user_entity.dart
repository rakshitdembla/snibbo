class UserEntity {
    String username;
    String name;
    String? profilePicture;
    bool isVerified;

    UserEntity({
        required this.username,
        required this.name,
        this.profilePicture,
        required this.isVerified,
    });
}