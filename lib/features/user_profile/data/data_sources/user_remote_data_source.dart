import 'package:my_tdd_app/features/user_profile/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserById(String id);
}
