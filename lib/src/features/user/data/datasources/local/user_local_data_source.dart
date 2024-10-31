import 'dart:convert';

import 'package:df_ist_flutter/src/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserDto user);

  Future<UserDto?> getCachedUser();
}

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedUserKey = 'CACHED_USER';

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUser(UserDto user) async {
    final userJson = json.encode(user.toJson());
    await sharedPreferences.setString(cachedUserKey, userJson);
  }

  @override
  Future<UserDto?> getCachedUser() async {
    final userJson = sharedPreferences.getString(cachedUserKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserDto.fromJson(userMap);
    }
    return null;
  }
}
