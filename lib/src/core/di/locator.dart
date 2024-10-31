import 'package:df_ist_flutter/src/core/di/locator.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init(environment: Environment.dev);

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
}
