import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_tdd_app/features/user_profile/data/data_sources/user_remote_data_source.dart';
import 'package:my_tdd_app/features/user_profile/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client client;
  late UserRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = UserRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });
  final testJson = fixture('user.json');
  debugPrint('$testJson');
  group('fetchUserId - ', () {
    test(
      'given UserRemoteDataSourceImpl '
      'when [UserRemoteDataSourceImpl.fetchUserById] is called '
      'and json response is not empty '
      'then return [UserModel]',
      () async {
        // Arrange
        when(
          () => client.get(
            any(),
          ),
        ).thenAnswer((_) async => Response(testJson, 200));
        // Act
        final userModel = await remoteDataSource.fetchUserById('1');
        // Assert
        expect(userModel, isA<UserModel>());
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'given UserRemoteDataSourceImpl '
      'when [UserRemoteDataSourceImpl.fetchUserById] is called '
      'and status is not 200 '
      'then return [Exception]',
      () async {
        // Arrange
        final testException = Exception('No user with id found');
        when(
          () => client.get(
            any(),
          ),
        ).thenThrow(testException);
        // Act
        final methodCall = remoteDataSource.fetchUserById;
        // Assert
        expect(() async => methodCall('1'), throwsA(isA<Exception>()));
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
