import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_states.dart';

class InputFieldBloc extends Bloc<InputFieldEvent, InputFieldState> {
  InputFieldBloc() : super(CommentFieldState()) {
    on<ShowCommentField>((event, emit) {
      emit(CommentFieldState());
    });

    on<ShowReplyField>((event, emit) {
      emit(ReplyFieldState(comment: event.comment));
    });
  }
}
