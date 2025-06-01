import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/entities/cloud_image_entity.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/create/data/models/create_post_model.dart';
import 'package:snibbo_app/features/create/domain/usecases/create_post_usecase.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_events.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_states.dart';
import 'package:snibbo_app/service_locator.dart';
import 'dart:io';

class CreatePostBloc extends Bloc<CreatePostEvents, CreatePostStates> {
      File? pickedFile;
  CreatePostBloc() : super(CreatePostInitial()) {
    on<CreatePost>((event, emit) async {
      emit(CreatePostLoading());
      //**
      //** @ Upload File on Cloudinary
      //**
      if (pickedFile == null) {
        emit(
          CreatePostError(
            title: "No Image Selected",
            description: "Please select an image first to post.",
          ),
        );
        return;
      }
      final (
        bool uploadSuccess,
        String? uploadError,
        CloudImageEntity? cloudImageEntity,
      ) = await ServicesUtils.uploadToCloud("Image", pickedFile!);
      //**
      //** @ Uploaded File Success & Null Check
      //**
      if (uploadSuccess && cloudImageEntity != null) {
        final userId = await ServicesUtils.getTokenId();
        //**
        //** @ Hit Create Post API Through UseCase
        //**
        final (bool success, String? message) = await sl<CreatePostUsecase>()
            .createPost(
              createPostModel: CreatePostModel(
                content: cloudImageEntity.secureUrl,
                contentType: "Image",
                captions: event.caption,
              ),
              userId: userId!,
            );

        if (success) {
          pickedFile = null;
          emit(
            CreatePostSuccess(
              description: message.toString(),
              title: "Post Created Successfully",
            ),
          );
        } else {
          emit(
            CreatePostError(
              title: "Failed to Upload Post",
              description: message ?? "Oops! Something went wrong.",
            ),
          );
        }
      } else {
        emit(
          CreatePostError(
            title: "Failed to Upload Post",
            description: uploadError ?? "Oops! Something went wrong.",
          ),
        );
      }
    });

    on<PickPostImage>((event, emit) async {
      emit(PickingPostImage());
      try {
        pickedFile = null;
        //**
        //** @ Pick Image
        //**
        final xfILE = await ServicesUtils.pickImage(
          event.imageSource,
          event.context,
        );
        //**
        //** @ Null Check for Picked XFile
        //**
        if (xfILE == null) {
          emit(
            PickPostImageError(
              title: "Failed to Select Image",
              description: "Image selection was cancelled or failed.",
            ),
          );
          return;
        }
        //**
        //** @ Coversion of XFile to File
        //**
        final File file = File(xfILE.path);
        //**
        //** @ File Length Validation - Max Length is 2MB here
        //**
        final fileLength = await file.length();
        if (fileLength > 2000000) {
          emit(
            PickPostImageError(
              title: "Failed to Select Image",
              description: "Image size too large. Maximum 2MB allowed.",
            ),
          );
          return;
        }

        emit(PickedPostImage(file: file));
        pickedFile = file;
      } catch (e) {
        emit(
          PickPostImageError(
            description: e.toString(),
            title: "Failed to Select Image",
          ),
        );
      }
    });
  }
}
