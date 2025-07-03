import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_events.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_states.dart';
import 'package:snibbo_app/features/create/presentation/widgets/captions_text_field.dart';
import 'package:snibbo_app/features/create/presentation/widgets/create_bottom_modal_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final FocusNode captionNode = FocusNode();
  final TextEditingController captionController = TextEditingController();

  @override
  void dispose() {
    captionNode.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Create Post")),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              width * 0.025,
              0,
              width * 0.025,
              UiUtils.bottomNavBar(context: context),
            ),
            child: BlocConsumer<CreatePostBloc, CreatePostStates>(
              listener: (context, state) {
                if (state is CreatePostError) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                } else if (state is CreatePostSuccess) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: true,
                    isWarning: false,
                  );
                  captionController.clear();
                } else if (state is PickPostImageError) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                }
              },
              builder: (context, state) {
                final createPostBloc = BlocProvider.of<CreatePostBloc>(context);
                final blocPickedImage =
                    context.read<CreatePostBloc>().pickedFile;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Image",
                      style: TextStyle(fontSize: width * 0.036),
                    ),
                    SizedBox(height: height * 0.009),
                    InkWell(
                      onTap: () {
                        if (state is PickingPostImage ||
                            state is CreatePostLoading) {
                          return;
                        }
                        CreateBottomModalSheet.show(
                          context: context,
                          isDark: isDark,
                          image: MyAssets.postImage,
                          h1: "Create Post",
                          h2:
                              "Upload your favorite image to connect with friends.",
                          cameraSourceTap: () {
                            createPostBloc.add(
                              PickPostImage(
                                context: context,
                                imageSource: ImageSource.camera,
                              ),
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          gallerySourceTap: () {
                            createPostBloc.add(
                              PickPostImage(
                                context: context,
                                imageSource: ImageSource.gallery,
                              ),
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? MyColors.darkTextFields
                                  : MyColors.textFields,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Stack(
                          children: [
                            if (blocPickedImage != null)
                              Image.file(
                                blocPickedImage,
                                width: double.infinity,
                                height: height * 0.2,
                                fit: BoxFit.contain,
                              ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.all(height * 0.003),
                                margin: EdgeInsets.all(height * 0.01),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryDense,
                                    width: 1.5.r,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child:
                                    state is PickingPostImage
                                        ? CircularProgressLoading(
                                          androidScaleSize: height * 0.0008,
                                        )
                                        : Icon(
                                          Icons.add,
                                          size: height * 0.025,
                                          color:
                                              isDark
                                                  ? MyColors.primary
                                                  : MyColors.darkPrimary,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Add caption",
                      style: TextStyle(fontSize: width * 0.036),
                    ),
                    SizedBox(height: height * 0.009),
                    CaptionsTextField(
                      captionController: captionController,
                      captionNode: captionNode,
                    ),
                    SizedBox(height: height * 0.05),
                    state is CreatePostLoading
                        ? Center(child: CircularProgressLoading())
                        : ElevatedCTA(
                          onPressed: () {
                            createPostBloc.add(
                              CreatePost(
                                caption: captionController.text.trim(),
                              ),
                            );
                          },
                          buttonName: "Upload",
                          isShort: false,
                        ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
