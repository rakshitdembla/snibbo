import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_states.dart';
import 'package:snibbo_app/features/create/presentation/widgets/captions_text_field.dart';
import 'package:snibbo_app/features/feed/presentation/helpers/update_post_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class UpdatePostScreen extends StatefulWidget {
  final String postId;
  final String imageUrl;
  final String username;
  final String initialCaption;

  const UpdatePostScreen({
    super.key,
    required this.postId,
    required this.username,
    required this.imageUrl,
    required this.initialCaption,
  });

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final FocusNode captionNode = FocusNode();
  late final TextEditingController captionController;

  @override
  void initState() {
    captionController = TextEditingController(text: widget.initialCaption);
    super.initState();
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
        actions: [
          BlocConsumer<DeletePostBloc, DeletePostState>(
            listenWhen: (previous, current) {
              if (current is DeletePostSuccess) {
                return current.postId == widget.postId;
              } else if (current is DeletePostError) {
                return current.postId == widget.postId;
              }
              return false;
            },
            listener: (context, state) {
              if (state is DeletePostSuccess) {
                UpdatePostEvents.delete(context: context, state: state);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: true,
                    isWarning: false,
                  );
                  context.router.pop();
                });
              } else if (state is DeletePostError) {
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
            buildWhen: (previous, current) {
              if (current is DeletePostSuccess) {
                return current.postId == widget.postId;
              } else if (current is DeletePostError) {
                return current.postId == widget.postId;
              } else if (current is DeletePostLoading) {
                return current.postId == widget.postId;
              }
              return false;
            },
            builder: (context, state) {
              if (state is DeletePostLoading) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.03),
                    child: CircularProgressLoading(),
                  ),
                );
              }
              return IconButton(
                onPressed: () {
                  BlocProvider.of<DeletePostBloc>(context).add(
                    DeletePost(
                      postId: widget.postId,
                      username: widget.username,
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                  size: height * 0.03,
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            width * 0.025,
            0,
            width * 0.025,
            UiUtils.bottomNavBar(context: context),
          ),
          child: BlocConsumer<UpdatePostBloc, UpdatePostState>(
            listenWhen: (previous, current) {
              if (current is UpdatePostError) {
                return current.postId == widget.postId;
              } else if (current is UpdatePostSuccess) {
                return current.postId == widget.postId;
              }
              return false;
            },
            listener: (context, state) {
              if (state is UpdatePostError) {
                UiUtils.showToast(
                  title: state.title,
                  description: state.description,
                  context: context,
                  isDark: isDark,
                  isSuccess: false,
                  isWarning: false,
                );
              } else if (state is UpdatePostSuccess) {
                UpdatePostEvents.update(context: context, state: state);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: true,
                    isWarning: false,
                  );
                  context.router.pop();
                });
              }
            },
            buildWhen: (previous, current) {
              if (current is UpdatePostSuccess) {
                return current.postId == widget.postId;
              } else if (current is UpdatePostLoading) {
                return current.postId == widget.postId;
              } else if (current is UpdatePostError) {
                return current.postId == widget.postId;
              }
              return false;
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Post Image", style: TextStyle(fontSize: width * 0.036)),
                  SizedBox(height: height * 0.009),
                  Container(
                    width: double.infinity,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? MyColors.darkTextFields
                              : MyColors.textFields,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.network(
                      widget.imageUrl,
                      width: double.infinity,
                      height: height * 0.2,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text("Image failed to load."));
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text("Caption", style: TextStyle(fontSize: width * 0.036)),
                  SizedBox(height: height * 0.009),
                  CaptionsTextField(
                    captionController: captionController,
                    captionNode: captionNode,
                  ),
                  SizedBox(height: height * 0.05),
                  state is UpdatePostLoading
                      ? Center(child: CircularProgressLoading())
                      : ElevatedCTA(
                        onPressed: () {
                          context.read<UpdatePostBloc>().add(
                            UpdatePost(
                              username: widget.username,
                              postId: widget.postId,
                              caption: captionController.text.trim(),
                            ),
                          );
                        },
                        buttonName: "Update",
                        isShort: false,
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
