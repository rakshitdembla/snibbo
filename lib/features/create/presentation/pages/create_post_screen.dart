import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
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
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            width * 0.025,
            0,
            width * 0.025,
            ServicesUtils.bottomNavBar(context: context) 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Image", style: TextStyle(fontSize: width * 0.036)),
              SizedBox(height: height * 0.009),
              Container(
                width: double.infinity,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: isDark ? MyColors.darkTextFields : MyColors.textFields,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Align(
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
                    child: Icon(
                      Icons.add,
                      size: height * 0.025,
                      color: isDark ? MyColors.primary : MyColors.darkPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text("Add caption", style: TextStyle(fontSize: width * 0.036)),
              SizedBox(height: height * 0.009),
              TextField(
                cursorColor: MyColors.secondaryDense,
                cursorErrorColor: MyColors.secondaryDense,
                controller: captionController,
                focusNode: captionNode,
                style: TextStyle(
                  color: isDark ? MyColors.white : MyColors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: height * 0.02,
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).unfocus();
                },
                maxLength: 200,
                textAlign: TextAlign.start,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: height * 0.015,horizontal: width * 0.02 ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: MyColors.searchField),
                  ),
                  filled: true,
                  fillColor:
                      isDark ? MyColors.darkTextFields : MyColors.textFields,
                ),
              ),
              SizedBox(height: height * 0.05),
              ElevatedCTA(
                onPressed: () {},
                buttonName: "Upload",
                isShort: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
