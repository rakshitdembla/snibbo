import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_states.dart';

class AnimatedLikeBloc extends Bloc<AnimatedLikeEvents, AnimatedLikeStates> {
  Map<String, bool> showLiked = {};
  AnimatedLikeBloc() : super(AnimatedLikeInitial()) {
    debugPrint('AnimatedLikeBloc initialized');
    
    on<DoubleTapLike>((event, emit) async {
      debugPrint("[DoubleTapLike] Received for postId: ${event.postId}");
      debugPrint("[DoubleTapLike] Current showLiked status: $showLiked");
      
      emit(ShowLikeState(postId: event.postId));
      showLiked[event.postId] = true;
      debugPrint("[DoubleTapLike] Updated showLiked[${event.postId}] to true");

      debugPrint("[DoubleTapLike] Starting 2700ms delay...");
      await Future.delayed(2700.ms);
      debugPrint("[DoubleTapLike] Delay completed");

      emit(HideLikeState(postid: event.postId));
      debugPrint("[DoubleTapLike] Emitted HideLikeState for postId: ${event.postId}");
    });

    on<RemoveShownLike>((event, emit) {
      debugPrint('[RemoveShownLike] Received for postId: ${event.postId}');
      debugPrint('[RemoveShownLike] Pre-update showLiked status: $showLiked');
      
      showLiked[event.postId] = false;
      emit(HideLikeState(postid: event.postId));
      
      debugPrint('[RemoveShownLike] Post-update showLiked status: $showLiked');
      debugPrint('[RemoveShownLike] Emitted HideLikeState for postId: ${event.postId}');
    });
  }
}
