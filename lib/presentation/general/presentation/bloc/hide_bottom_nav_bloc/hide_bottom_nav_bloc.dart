import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_events.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_states.dart';

class HideBottomNavBloc extends Bloc<HideBottomNavEvents, HideBottomNavStates> {
  HideBottomNavBloc() : super(BottomNavBarInitial()) {
    on<HideBottomNavBar>((event, emit) {
      emit(BottomNavBarHidden());
    });

    on<ShowBottomNavBar>((event, emit) {
      emit(BottomNavBarShown());
    });
  }
}
