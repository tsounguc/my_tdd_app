import 'package:flutter_test/flutter_test.dart';
import 'package:my_tdd_app/features/user_profile/data/models/user_model.dart'; // New import
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testJson = fixture('user.json');
  final testUserModel = UserModel.fromJson(testJson);
  final testMap = testUserModel.toJson();
  test(
    'given [UserModel], '
    'when instantiated '
    'then instance should be a subclass of [User] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testUserModel, isA<User>());
    },
  );

  group('fromJson - ', () {
    test(
      'given [UserModel], '
      'when fromJson is called, '
      'then return [UserModel] with correct data ',
      () {
        // Arrange
        // Act
        final result = UserModel.fromJson(testJson);
        // Assert
        expect(result, isA<UserModel>());
        expect(result, equals(testUserModel));
      },
    );
  });

  group('toJson - ', () {
    test(
      'given [UserModel], '
      'when toJson is called, '
      'then return a json String with correct data ',
      () {
        // Arrange
        // Act
        final result = testUserModel.toJson();
        // Assert
        expect(result, equals(testMap));
      },
    );
  });

  group('fromMap - ', () {
    test(
      'given [UserModel], '
      'when fromMap is called, '
      'then return [UserModel] with correct data ',
      () {
        // Arrange
        // Act
        final result = UserModel.fromMap(testMap);
        // Assert
        expect(result, isA<UserModel>());
        expect(result, equals(testUserModel));
      },
    );
  });

  group('copyWith - ', () {
    const testName = 'John Doe';
    test(
      'given [UserModel], '
      'when fromMap is called, '
      'then return [UserModel] with correct data ',
      () {
        // Arrange
        // Act
        final result = testUserModel.copyWith(name: testName);
        // Assert
        expect(result.name, equals(testName));
      },
    );
  });
}
