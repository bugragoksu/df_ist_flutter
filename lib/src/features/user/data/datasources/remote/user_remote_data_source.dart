import 'package:df_ist_flutter/src/core/network/api_client.dart';
import 'package:df_ist_flutter/src/features/user/data/dto/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<UserDto> getUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserDto> getUser(int id) async {
    try {
      final response = await apiClient.get('/users/$id');
      return UserDto.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load user data");
    }
  }
}
