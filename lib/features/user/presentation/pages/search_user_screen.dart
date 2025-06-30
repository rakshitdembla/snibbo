import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/network/helpers/search_debouncing.dart';
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
  final SearchDebouncingHelper _debouncer = SearchDebouncingHelper();

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

  void searchUser({required String value}) {
    final String finalValue =
        value.startsWith("@") ? value.substring(1) : value;

    _debouncer.onChanged(
      onTimerEnd: () {
        BlocProvider.of<SearchUserBloc>(
          context,
        ).add(SearchUserByUsername(username: finalValue));
      },
    );
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
          isMini: false,
          onChanged: (value) {
            searchUser(value: value);
          },
          focusNode: FocusNode(),
          textEditingController: textEditingController,
          hintText: "Search username",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.005),
          child: BlocBuilder<SearchUserBloc, SearchUserState>(
            builder: (context, state) {
              if (state is SearchUserNotFound) {
                return Center(child: Text("No Users Found"));
              } else if (state is SearchUserFound) {
                final users = state.user;

                if (users.isEmpty) {
                  return Center(child: Text("No Users Found"));
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserListTile(
                      user: user,
                      isDark: isDark,
                      isStatic: false,
                    );
                  },
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
