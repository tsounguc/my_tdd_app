import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_tdd_app/core/errors/failures.dart';
import 'package:my_tdd_app/features/user_profile/data/data_sources/user_remote_data_source.dart';
import 'package:my_tdd_app/features/user_profile/data/models/user_model.dart';
import 'package:my_tdd_app/features/user_profile/data/repositories/user_repository_impl.dart'; // New import
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:my_tdd_app/features/user_profile/domain/repositories/user_repository.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late UserRemoteDataSource remoteDataSource;
  late UserRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockUserRemoteDataSource();
    repositoryImpl = UserRepositoryImpl(remoteDataSource);
  });

  test(
    'given UserRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [AuthRepository]',
    () {
      expect(repositoryImpl, isA<UserRepository>());
    },
  );
  group('getUserById - ', () {
    const testModel = UserModel(id: 1, name: 'John Doe');
    final testException = Exception('message');
    final testFailure = Failure(testException.toString());
    test(
      'given UserRepositoryImpl '
      'when [UserRepositoryImpl.getUserById] is called '
      'then return [User] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.fetchUserById(any()),
        ).thenAnswer((_) async => testModel);
        // Act
        final result = await repositoryImpl.getUserById('1');
        // Assert
        expect(
          result,
          equals(const Right<Failure, User>(testModel)),
        );
        verify(
          () => remoteDataSource.fetchUserById('${testModel.id}'),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given UserRepositoryImpl '
      'when [UserRepositoryImpl.getUserById] is called '
      'and remote data source call unsuccessful '
      'then return [Failure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.fetchUserById(any()),
        ).thenThrow(testException);
        // Act
        final result = await repositoryImpl.getUserById('1');
        // Assert
        expect(
          result,
          equals(Left<Failure, User>(testFailure)),
        );
        verify(
          () => remoteDataSource.fetchUserById('${testModel.id}'),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
