import 'package:json_annotation/json_annotation.dart';
part 'register_req_model.g.dart';

@JsonSerializable()
class RegisterReqModel {

  final String email;
  final String name;
  final String username;
  final String password;

  RegisterReqModel({
    required this.email,required this.name,required this.password,required this.username
  });

  Map<String,dynamic> toJson() => _$RegisterReqModelToJson(this);
}