import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_listtile.dart';
import 'package:snibbo_app/features/explore/presentation/widgets/search_field.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_states.dart';

@RoutePage()
class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<SearchUserBloc>(context).add(ResetSearch());
    super.initState();
  }

  void searchUser() {
    final String controllerText = textEditingController.text;
    final String finalValue =
        controllerText.startsWith("@")
            ? controllerText.substring(1)
            : controllerText;

    final isLoading = context.read<SearchUserBloc>().state is SearchUserLoading;
    if (!isLoading) {
      BlocProvider.of<SearchUserBloc>(
        context,
      ).add(SearchUserByUsername(username: finalValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: isDark ? MyColors.white : MyColors.black,
        ),
        title: SearchField(
          onSubmit: (value) {
            searchUser();
          },
          onIconTap: () {
            searchUser();
          },
          focusNode: FocusNode(),
          textEditingController: textEditingController,
          prefixIcon: Icons.search_rounded,
          hintText: "@rakshitdembla",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.005),
          child: BlocConsumer<SearchUserBloc, SearchUserState>(
            listener: (context, state) {
              if (state is SearchUserEmptyState) {
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
              if (state is SearchUserNotFound) {
                return Center(child: Text("No User Found"));
              } else if (state is SearchUserFound) {
                return UserListTile(
                  name: state.user.name,
                  profileUrl: state.user.profilePicture.toString(),
                  username: state.user.username,
                  isDark: isDark,
                );
              } else if (state is SearchUserLoading) {
                return Center(child: CircularProgressLoading());
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
