import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';

class UpdatePostEvents {
  static void update({
    required BuildContext context,
    required UpdatePostSuccess state,
  }) {
    BlocProvider.of<UserPostsPaginationBloc>(context).add(
      UpdateUserPost(
        postId: state.postId,
        username: state.username,
        updatedCaptions: state.updatedCaptions,
      ),
    );

    BlocProvider.of<UserSavedPostsPaginationBloc>(context).add(
      UpdateUserSavedPost(
        postId: state.postId,
        username: state.username,
        updatedCaptions: state.updatedCaptions,
      ),
    );

    BlocProvider.of<PostPaginationBloc>(context).add(
      UpdateFeedPost(
        postId: state.postId,
        updatedCaptions: state.updatedCaptions,
      ),
    );
    BlocProvider.of<ExplorePostsBloc>(context).add(
      UpdateExplorePost(
        postId: state.postId,
        updatedCaptions: state.updatedCaptions,
      ),
    );
  }

  static void delete({
    required BuildContext context,
    required DeletePostSuccess state,
  }) {
    BlocProvider.of<UserPostsPaginationBloc>(
      context,
    ).add(DeleteUserPost(postId: state.postId, username: state.username));

    BlocProvider.of<UserSavedPostsPaginationBloc>(
      context,
    ).add(DeleteUserSavedPost(postId: state.postId, username: state.username));

    BlocProvider.of<PostPaginationBloc>(
      context,
    ).add(DeleteFeedPost(postId: state.postId));
    BlocProvider.of<ExplorePostsBloc>(
      context,
    ).add(DeleteExplorePost(postId: state.postId));
  }
}
