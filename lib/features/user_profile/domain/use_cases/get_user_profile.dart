import 'package:dartz/dartz.dart';
import 'package:my_tdd_app/core/errors/failures.dart';
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:my_tdd_app/features/user_profile/domain/repositories/user_repository.dart';

class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, User>> call(String userId) {
    return repository.getUserById(userId);
  }
}
