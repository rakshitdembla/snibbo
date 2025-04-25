import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc({required Brightness initialBrightness})
    : super(
        initialBrightness == Brightness.dark
            ? DarkThemeState()
            : LightThemeState(),
      ) {
    on<ToogleTheme>((event, emit) {
      if (event.isDark) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
