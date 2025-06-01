import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_states.dart';

class AnimatedLikeBloc extends Bloc<AnimatedLikeEvents, AnimatedLikeStates> {
  Map<String, bool> showLiked = {};
  AnimatedLikeBloc() : super(AnimatedLikeInitial()) {
    on<DoubleTapLike>((event, emit) async {
      debugPrint("Double Tapped Liked showLiked status - $showLiked");
      emit(ShowLikeState(postId: event.postId));
      showLiked[event.postId] = true;

      await Future.delayed(2700.ms);

      emit(HideLikeState(postid: event.postId));
    });

    on<RemoveShownLike>((event, emit) {
      debugPrint('Remove shown lik event showLikedStatus $showLiked');
      showLiked[event.postId] = false;
      emit(HideLikeState(postid: event.postId));
      debugPrint('Remove shown lik event showLikedStatus $showLiked');
    });
  }
}
