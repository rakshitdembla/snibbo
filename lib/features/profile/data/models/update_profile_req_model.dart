class UpdateProfileReqModel {
  final String? profileUrl;
  final String name;
  final String username;
  final String bio;

  UpdateProfileReqModel({
    required this.bio,
    required this.name,
    required this.username,
    this.profileUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "username": username,
      "bio": bio,
    };
    
    if (profileUrl != null) {
      data["profilePicture"] = profileUrl;
    }

    return data;
  }
}

