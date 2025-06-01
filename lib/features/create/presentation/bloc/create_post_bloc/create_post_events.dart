import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreatePostEvents {}

class CreatePost extends CreatePostEvents {
  final String caption;

  CreatePost({
    required this.caption,
  });
}

class PickPostImage extends CreatePostEvents{
  final BuildContext context;
    final ImageSource imageSource;
    PickPostImage({
      required this.context,required this.imageSource
    });

}
