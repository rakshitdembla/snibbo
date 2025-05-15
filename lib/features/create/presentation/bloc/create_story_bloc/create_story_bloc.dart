import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/create/data/data_sources/remote/content_creator_remote_data.dart';
import 'package:snibbo_app/features/create/data/models/create_story_model.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_Story_events.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_states.dart';
import 'package:snibbo_app/service_locator.dart';

class CreateStoryBloc extends Bloc<CreateStoryEvents, CreateStoryStates> {
  CreateStoryBloc() : super(CreateStoryInitialState()) {
    on<CreateStory>((event, emit) async {
      emit(CreateStoryLoadingState());

      final (
        uploadSuccess,
        uploadMessage,
        imageUrl,
      ) = await sl<ContentCreatorRemoteData>().uploadImage(
        context: event.context,
        imageSource: event.imageSource,
        type: "Story",
      );

      if (!uploadSuccess || imageUrl == null) {
        emit(
          CreateStoryErrorState(
            description: uploadMessage.toString(),
            title: "Failed to upload story.",
          ),
        );
        return;
      }

      final userId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<ContentCreatorRemoteData>()
          .createStory(
            createStoryModel: CreateStoryModel(
              storyContent: imageUrl,
              contentType: "Image",
            ),
            userId: userId!,
          );

      if (!success) {
        emit(
          CreateStoryErrorState(
            description: message.toString(),
            title: "Failed to upload story.",
          ),
        );
        return;
      } else {
        debugPrint("emitting success state");
        emit(
          CreateStorySucessState(
            description: message.toString(),
            title: "Story created successfully.",
          ),
        );
      }
    });
  }
}
