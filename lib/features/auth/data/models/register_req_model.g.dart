// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterReqModel _$RegisterReqModelFromJson(Map<String, dynamic> json) =>
    RegisterReqModel(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$RegisterReqModelToJson(RegisterReqModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
    };
