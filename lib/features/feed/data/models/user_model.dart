import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class UserModel {
  String username;
  String name;
  String? profilePicture;
  bool isVerified;

  UserModel({
    required this.username,
    required this.name,
    this.profilePicture,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    name: json["name"],
    profilePicture: json["profilePicture"] ?? "",
    isVerified: json["isVerified"],
  );

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      name: name,
      isVerified: isVerified,
    );
  }
}
