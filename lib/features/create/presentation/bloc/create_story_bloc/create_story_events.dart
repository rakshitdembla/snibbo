import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateStoryEvents {}

class CreateStory extends CreateStoryEvents {
  final ImageSource imageSource;
  final BuildContext context;

  CreateStory({required this.context,required this.imageSource});
}
