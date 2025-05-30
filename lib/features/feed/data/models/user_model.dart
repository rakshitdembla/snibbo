import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class UserModel {
  String username;
  String name;
  String? profilePicture;
  bool isVerified;
  bool? storiesSeen;

  UserModel({
    required this.username,
    required this.name,
    this.profilePicture,
    required this.isVerified,
    this.storiesSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    name: json["name"],
    profilePicture: json["profilePicture"] ?? "",
    isVerified: json["isVerified"],
    storiesSeen: json["storiesSeen"],
  );

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      isVerified: isVerified,
      storiesSeen: storiesSeen,
    );
  }
}
