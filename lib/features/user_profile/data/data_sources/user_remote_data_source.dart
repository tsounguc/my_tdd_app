import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_tdd_app/features/user_profile/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserById(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._client);
  final Client _client;

  @override
  Future<UserModel> fetchUserById(String id) async {
    try {
      final url = 'https://jsonplaceholder.typicode.com/users/$id';
      final parsedUri = Uri.parse(url);
      final response = await _client.get(parsedUri);
      if(response.body == '{}'){
        throw Exception('No user with id $id found');
      }
      final user = UserModel.fromJson(response.body);
      return user;
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: 'Failed to fetch user: $e');
      throw Exception('Network error: $e');
    }
  }
}
