import 'package:flutter_bloc/flutter_bloc.dart';
import 'like_post_events.dart';
import 'like_post_states.dart';

class LikePostBloc extends Bloc<LikePostEvents, LikePostStates> {
  bool alreadyLiked = false;

  LikePostBloc() : super(LikePostInitial()) {
    on<LikePost>((event, emit) {
    });

    on<DisLikePost>((event, emit) {
    });

    on<TapLike>((event, emit) async{
      emit(TapLikeShowState());

      await Future.delayed(Duration(milliseconds: 2700));

      emit(TapLikeHideState());

      
    },);
  }
}