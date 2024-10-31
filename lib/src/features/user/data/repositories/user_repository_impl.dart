import 'package:dartz/dartz.dart';
import 'package:df_ist_flutter/src/core/error/failure.dart';
import 'package:df_ist_flutter/src/features/user/data/datasources/local/user_local_data_source.dart';
import 'package:df_ist_flutter/src/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:df_ist_flutter/src/features/user/domain/models/user_model.dart';
import 'package:df_ist_flutter/src/features/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> getUser(int id) async {
    try {
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser.toModel());
      }
      final remoteUser = await remoteDataSource.getUser(id);
      await localDataSource.cacheUser(remoteUser);
      return Right(remoteUser.toModel());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
