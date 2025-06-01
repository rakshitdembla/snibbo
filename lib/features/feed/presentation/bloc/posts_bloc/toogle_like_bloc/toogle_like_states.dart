abstract class ToogleLikeStates {}

class ToogleLikeInitial extends ToogleLikeStates {}

class ToogleLikeLoading extends ToogleLikeStates {}

class ToogleLikeSuccess extends ToogleLikeStates {}

class ToogleLikeError extends ToogleLikeStates {
  final String title;
  final String description;

  ToogleLikeError({required this.description, required this.title});
}
