import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_Story_events.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/create/presentation/widgets/create_bottom_modal_sheet.dart';

class CreateStorySheet {
  static Future<dynamic> show({
    required BuildContext context,
    required bool isDark,
  }) async {
    return CreateBottomModalSheet.show(
      context: context,
      isDark: isDark,
      image: MyAssets.storyImage,
      h1: "Create Your Story",
      h2:
          "Capture a photo or pick one from your gallery to begin sharing your special moments.",
      cameraSourceTap: () {
        Navigator.pop(context);
        context.read<CreateStoryBloc>().add(
          CreateStory(context: context, imageSource: ImageSource.camera),
        );
      },
      gallerySourceTap: () {
        Navigator.pop(context);
        context.read<CreateStoryBloc>().add(
          CreateStory(context: context, imageSource: ImageSource.gallery),
        );
      },
    );
  }
}
