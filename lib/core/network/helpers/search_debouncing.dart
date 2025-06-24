import 'dart:async';

class SearchDebouncingHelper {
  Timer? _debounce;

  void onChanged({required dynamic onTimerEnd}) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(seconds: 1), onTimerEnd);
  }
}
