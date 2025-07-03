import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/deep_link_view/presentation/bloc/get_single_post_bloc.dart';
import 'package:snibbo_app/features/deep_link_view/presentation/bloc/get_single_post_events.dart';
import 'package:snibbo_app/features/deep_link_view/presentation/bloc/get_single_post_states.dart';

@RoutePage()
class LinkPostViewScreen extends StatefulWidget {
  final String postId;
  const LinkPostViewScreen({super.key, required this.postId});

  @override
  State<LinkPostViewScreen> createState() => _LinkPostViewScreenState();
}

class _LinkPostViewScreenState extends State<LinkPostViewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetSinglePostBloc>().add(
      GetSinglePostData(postId: widget.postId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    return Scaffold(
      appBar: AppBar(title: const Text("Shared Post")),
      body: MyRefreshBar(
        onRefresh: () async {
          context.read<GetSinglePostBloc>().add(
            GetSinglePostData(postId: widget.postId),
          );
        },
        widget: BlocConsumer<GetSinglePostBloc, GetSinglePostState>(
          listener: (context, state) {
            if (state is GetSinglePostErrorState) {
              UiUtils.showToast(
                title: state.title,
                description: state.description,
                context: context,
                isDark: isDark,
                isSuccess: false,
                isWarning: false,
              );
            }
          },
          builder: (context, state) {
            if (state is GetSinglePostErrorState) {
              return Padding(
                padding: EdgeInsetsGeometry.only(
                  top: UiUtils.screenHeight(context) * 0.03,
                ),
                child: ErrorScreen(isFeedError: false),
              );
            } else if (state is GetSinglePostSuccessState) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: PostWidget(postEntity: state.postEntity),
                ),
              );
            } else {
              return const Center(child: CircularProgressLoading());
            }
          },
        ),
      ),
    );
  }
}
