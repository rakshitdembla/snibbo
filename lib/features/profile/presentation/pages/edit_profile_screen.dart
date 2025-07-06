import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/text_field.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_events.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_states.dart';
import 'package:snibbo_app/features/profile/presentation/widgets/request_blue_tick_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  final String username;
  final String name;
  final String profileUrl;
  final String bio;
  const EditProfileScreen({
    super.key,
    required this.bio,
    required this.name,
    required this.profileUrl,
    required this.username,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();

  File? updatedProfile;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _nameController = TextEditingController(text: widget.name);
    _bioController = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();

    _usernameFocus.dispose();
    _nameFocus.dispose();
    _bioFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            fontSize: height * 0.021,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final pickedImage = await ServicesUtils.pickImage(
                    ImageSource.gallery,
                    context,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      updatedProfile = File(pickedImage.path);
                    });
                  }
                },
                child: UserCircularProfileWidget(
                  username: widget.username,
                  isStatic: true,
                  profileUrl: updatedProfile ?? widget.profileUrl,
                  margins: EdgeInsets.only(bottom: height * 0.005),
                  storySize: 0.13,
                  hasActiveStories: false,
                  isAllStoriesViewed: false,
                  isFile: updatedProfile == null ? false : true,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final pickedImage = await ServicesUtils.pickImage(
                    ImageSource.gallery,
                    context,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      updatedProfile = File(pickedImage.path);
                    });
                  }
                },
                child: Text(
                  "Edit picture",
                  style: TextStyle(   overflow: TextOverflow.ellipsis,
                    fontSize: width * 0.03,
                    color: const Color.fromARGB(255, 77, 86, 255),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              MyTextField(
                hintText: MyStrings.nameHintText,
                label: "Name",
                focusNode: _nameFocus,
                isPassword: false,
                textEditingController: _nameController,
                maxLength: 30,
                maxLines: 1,
                onSubmit: (String value) {
                  FocusScope.of(context).requestFocus(_usernameFocus);
                },
                prefixIcon: Icons.person,
              ),
              SizedBox(height: height * 0.02),
              MyTextField(
                label: "Username",
                focusNode: _usernameFocus,
                isPassword: false,
                textEditingController: _usernameController,
                maxLength: 20,
                maxLines: 1,
                onSubmit: (String value) {
                  FocusScope.of(context).requestFocus(_bioFocus);
                },
                prefixIcon: Icons.alternate_email,
                hintText: MyStrings.usernameHintText,
              ),
              SizedBox(height: height * 0.02),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyTextField(
                    hintText: MyStrings.bioHintText,
                    label: "Bio",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^.*(\n?.*){0,3}$'),
                      ),
                    ],
                    focusNode: _bioFocus,
                    isPassword: false,
                    textEditingController: _bioController,
                    maxLength: 150,
                    maxLines: 4,
                    onSubmit: (String value) {
                      FocusScope.of(context).unfocus();
                    },
                    prefixIcon: Icons.info_outline,
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(right: width * 0.001,top: height * 0.002),
                    child: Text("Max 4 lines allowed!",style: TextStyle(   overflow: TextOverflow.ellipsis,
                      color: MyColors.grey,
                      fontSize: height * 0.013
                    ),),
                  )
                ],
              ),
              SizedBox(height: height * 0.05),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileError) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: false,
                      isWarning: false,
                    );
                  } else if (state is UpdateProfileSuccess) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: true,
                      isWarning: false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdateProfileLoading) {
                    return Center(child: CircularProgressLoading());
                  }
                  return ElevatedCTA(
                    onPressed: () {
                      BlocProvider.of<UpdateProfileBloc>(context).add(
                        SubmitProfileUpdate(
                          bio: _bioController.text.trim(),
                          name: _nameController.text.trim(),
                          updatedProfile: updatedProfile,
                          username:
                              _usernameController.text.trim().toLowerCase(),
                          context: context,
                        ),
                      );
                    },
                    buttonName: "Update",
                    isShort: false,
                  );
                },
              ),
              SizedBox(height: height * 0.03),
              RequestBlueTickWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
