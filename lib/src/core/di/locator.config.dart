// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:df_ist_flutter/src/core/di/locator.dart' as _i11;
import 'package:df_ist_flutter/src/core/network/api_client.dart' as _i6;
import 'package:df_ist_flutter/src/features/user/data/datasources/local/user_local_data_source.dart'
    as _i5;
import 'package:df_ist_flutter/src/features/user/data/datasources/remote/user_remote_data_source.dart'
    as _i7;
import 'package:df_ist_flutter/src/features/user/data/repositories/user_repository_impl.dart'
    as _i9;
import 'package:df_ist_flutter/src/features/user/domain/repositories/user_repository.dart'
    as _i8;
import 'package:df_ist_flutter/src/features/user/domain/usecases/get_user_usecase.dart'
    as _i10;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.dio);
    gh.singletonAsync<_i4.SharedPreferences>(
        () => registerModule.sharedPreferences);
    gh.factoryAsync<_i5.UserLocalDataSource>(() async =>
        _i5.UserLocalDataSourceImpl(await getAsync<_i4.SharedPreferences>()));
    gh.factory<_i6.ApiClient>(() => _i6.ApiClient(dio: gh<_i3.Dio>()));
    gh.factory<_i7.UserRemoteDataSource>(
        () => _i7.UserRemoteDataSourceImpl(gh<_i6.ApiClient>()));
    gh.factoryAsync<_i8.UserRepository>(() async => _i9.UserRepositoryImpl(
          remoteDataSource: gh<_i7.UserRemoteDataSource>(),
          localDataSource: await getAsync<_i5.UserLocalDataSource>(),
        ));
    gh.factoryAsync<_i10.GetUserUsecase>(
        () async => _i10.GetUserUsecase(await getAsync<_i8.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}
