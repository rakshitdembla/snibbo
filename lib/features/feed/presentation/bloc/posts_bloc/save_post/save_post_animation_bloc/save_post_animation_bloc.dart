import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'save_post_animation_events.dart';
import 'save_post_animation_states.dart';

class SavePostAnimationBloc extends Bloc<SavePostAnimationEvents, SavePostAnimationStates> {
  SavePostAnimationBloc() : super(SavePostAnimationInitial()) {
    debugPrint('SavePostAnimationBloc initialized');

    on<TapSavePost>((event, emit) async {
      emit(ShowSaveAnimationState(postId: event.postId));

      await Future.delayed(400.ms);

      emit(HideSaveAnimationState(postId: event.postId));
    });

    on<TapUnsavePost>((event, emit) {
      emit(HideSaveAnimationState(postId: event.postId));
    });
  }
}
