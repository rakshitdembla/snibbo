import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_states.dart';

class AnimatedLikeBloc extends Bloc<AnimatedLikeEvents, AnimatedLikeStates> {
  AnimatedLikeBloc() : super(AnimatedLikeInitial()) {
    debugPrint('AnimatedLikeBloc initialized');

    on<DoubleTapLike>((event, emit) async {
      emit(ShowLikeState(postId: event.postId));

      await Future.delayed(2700.ms);

      emit(HideLikeState(postid: event.postId));
    });

    on<TappedDislike>((event, emit) {
      emit(HideLikeState(postid: event.postId));
    });
  }
}
