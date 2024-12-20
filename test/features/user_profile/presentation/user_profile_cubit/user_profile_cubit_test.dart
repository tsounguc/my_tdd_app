import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_tdd_app/core/errors/failures.dart';
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:my_tdd_app/features/user_profile/domain/use_cases/get_user_profile.dart';
import 'package:bloc_test/bloc_test.dart';
// New Import
import 'package:my_tdd_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';

class MockGetUserProfile extends Mock implements GetUserProfile {}

void main() {
  late GetUserProfile getUserProfile;
  late UserProfileCubit cubit;
  setUp(() {
    getUserProfile = MockGetUserProfile();
    cubit = UserProfileCubit(getUserProfile: getUserProfile);
  });

  tearDown(() => cubit.close());

  // Verify that the initial state is set correctly
  test(
    'given UserProfileCubit '
    'when cubit is instantiated '
    'then initial state should be [UserProfileInitial]',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const UserProfileInitial());
    },
  );

  // Test  the method that loads user data
  group('loadUserProfile - ', () {
    const testUser = User(id: 1, name: 'John Doe');
    const testFailure = Failure('message');
    blocTest<UserProfileCubit, UserProfileState>(
      'given UserProfileCubit '
      'when [UserProfileCubit.loadUserProfile] call completed successfully '
      'then emit [LoadingUserProfile, UserProfileLoaded]',
      build: () {
        when(() => getUserProfile(any())).thenAnswer(
          (_) async => const Right(testUser),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadUserProfile('${testUser.id}'),
      expect: () => [
        LoadingUserProfile(),
        UserProfileLoaded(user: testUser),
      ],
      verify: (cubit) {
        verify(() => getUserProfile(any())).called(1);
        verifyNoMoreInteractions(getUserProfile);
      },
    );

    blocTest<UserProfileCubit, UserProfileState>(
      'given UserProfileCubit '
      'when [UserProfileCubit.loadUserProfile] call unsuccessful '
      'then emit [LoadingUserProfile, UserProfileError]',
      build: () {
        when(() => getUserProfile(any())).thenAnswer(
          (_) async => const Left(testFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadUserProfile('${testUser.id}'),
      expect: () => [
        LoadingUserProfile(),
        UserProfileError(message: testFailure.message),
      ],
      verify: (cubit) {
        verify(() => getUserProfile(any())).called(1);
        verifyNoMoreInteractions(getUserProfile);
      },
    );
  });
}
