import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/user_profile_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserProfile>((event, emit) async {
      emit(UserProfileLoading());
      final userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        ProfileEntity? profileEntity,
        String? message,
      ) = await sl<UserProfileUsecase>().getUserProfile(
        username: event.username,
        userId: userId!,
      );
      final myUsername = await ServicesUtils.getUsername();

      if (success && profileEntity != null) {
        emit(
          UserProfileSuccess(
            isMyProfile: profileEntity.username == myUsername,
            profileEntity: profileEntity,
          ),
        );
        return;
      }

      emit(
        UserProfileError(
          description: message.toString(),
          title: "Failed to load user profile",
        ),
      );
    });
  }
}
