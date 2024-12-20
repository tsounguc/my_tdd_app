import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:my_tdd_app/features/user_profile/domain/use_cases/get_user_profile.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({required GetUserProfile getUserProfile})
      : _getUserProfile = getUserProfile,
        super(const UserProfileInitial());

  final GetUserProfile _getUserProfile;

  Future<void> loadUserProfile(String userId) async {
    emit(const LoadingUserProfile());

    final result = await _getUserProfile(userId);

    result.fold(
      (failure) => emit(UserProfileError(message: failure.message)),
      (user) => emit(UserProfileLoaded(user: user)),
    );
  }
}
