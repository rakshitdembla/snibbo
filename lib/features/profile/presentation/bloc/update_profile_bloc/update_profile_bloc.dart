import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/entities/cloud_image_entity.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/profile/data/models/update_profile_req_model.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_events.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_events.dart';
import 'package:snibbo_app/service_locator.dart';
import '../../../domain/usecases/update_profile_usecase.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<SubmitProfileUpdate>((event, emit) async {
      emit(UpdateProfileLoading());

      final String username = event.username.trim();
      final String name = event.name.trim();
      final String bio = event.bio.trim();
      final File? updatedProfile = event.updatedProfile;
      String? profileUrl;

      if (username.trim().isEmpty || name.trim().isEmpty) {
        emit(
          UpdateProfileError(
            title: "Missing Fields",
            description: "Name and username cannot be empty.",
          ),
        );
        return;
      }

      // Name validation
      if (name.length < 2) {
        emit(
          UpdateProfileError(
            title: "Name Too Short",
            description: "Name must be at least 2 characters long.",
          ),
        );
        return;
      } else if (name.length > 30) {
        emit(
          UpdateProfileError(
            title: "Name Too Long",
            description: "Name must not exceed 30 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.nameValidator(name)) {
        emit(
          UpdateProfileError(
            title: "Invalid Name",
            description: "Name cannot contain numbers or special characters.",
          ),
        );
        return;
      }

      // Username validation
      if (username.length < 4) {
        emit(
          UpdateProfileError(
            title: "Username Too Short",
            description: "Username must be at least 4 characters long.",
          ),
        );
        return;
      } else if (username.length > 20) {
        emit(
          UpdateProfileError(
            title: "Username Too Long",
            description: "Username must not exceed 20 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.usernameValidator(username)) {
        emit(
          UpdateProfileError(
            title: "Invalid Username",
            description:
                "Username cannot contain spaces or special characters.",
          ),
        );
        return;
      }

      if (updatedProfile != null) {
        final fileLength = await updatedProfile.length();
        if (fileLength > 2000000) {
          emit(
            UpdateProfileError(
              title: "Failed to Upload Image",
              description: "Image size too large. Maximum 2MB allowed.",
            ),
          );
          return;
        }

        final (
          bool cloudSuccess,
          String? cloudMessage,
          CloudImageEntity? cloudEntity,
        ) = await ServicesUtils.uploadToCloud("Image", updatedProfile);

        if (cloudSuccess && cloudEntity != null) {
          profileUrl = cloudEntity.secureUrl;
        } else {
          emit(
            UpdateProfileError(
              title: "Failed to update profile",
              description: cloudMessage.toString(),
            ),
          );
          return;
        }
      }
      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<UpdateProfileUsecase>().call(
        userId: userId!,
        updateProfileReqModel: UpdateProfileReqModel(
          bio: bio,
          name: name,
          username: username,
          profileUrl: profileUrl,
        ),
      );

      if (success) {
        await ServicesUtils.saveUsername(username);
        final context = event.context;

        if (context.mounted) {
          BlocProvider.of<UserProfileBloc>(
            context,
          ).add(GetUserProfile(username: username));
          context.router.pop();
        }
        await Future.delayed(1.seconds);
        emit(
          UpdateProfileSuccess(
            username: event.username.trim(),
            title: "Profile Updated",
            description:
                message ?? "Your profile has been successfully updated.",
          ),
        );
      } else {
        emit(
          UpdateProfileError(
            title: "Update Failed",
            description:
                message ?? "Could not update profile. Please try again.",
          ),
        );
      }
    });
  }
}
