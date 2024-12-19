import 'package:my_tdd_app/core/errors/failures.dart';
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(String id);
}
