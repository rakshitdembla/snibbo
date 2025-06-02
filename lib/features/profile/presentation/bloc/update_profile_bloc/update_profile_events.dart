import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class SubmitProfileUpdate extends UpdateProfileEvent {
  final String username;
  final String bio;
  final String name;
  final File? updatedProfile;
  final BuildContext context;

  const SubmitProfileUpdate({
    required this.bio,
    required this.name,
    this.updatedProfile,
    required this.username,
    required this.context,
  });

  @override
  List<Object?> get props => [bio, name, username, updatedProfile];
}
