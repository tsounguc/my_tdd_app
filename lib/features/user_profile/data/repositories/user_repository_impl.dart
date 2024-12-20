import 'package:dartz/dartz.dart';
import 'package:my_tdd_app/core/errors/failures.dart';
import 'package:my_tdd_app/features/user_profile/data/data_sources/user_remote_data_source.dart';
import 'package:my_tdd_app/features/user_profile/domain/entities/user.dart';
import 'package:my_tdd_app/features/user_profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.remoteDataSource);
  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    try {
      final userModel = await remoteDataSource.fetchUserById(id);
      return Right(userModel);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
