class UserId {
    String username;
    String name;
    String? profilePicture;
    bool isVerified;

    UserId({
        required this.username,
        required this.name,
        this.profilePicture,
        required this.isVerified,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        username: json["username"],
        name: json["name"],
        profilePicture: json["profilePicture"] ?? "",
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "profilePicture": profilePicture ?? "",
        "isVerified": isVerified,
    };
}