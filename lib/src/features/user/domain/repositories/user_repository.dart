import 'package:dartz/dartz.dart';
import 'package:df_ist_flutter/src/core/error/failure.dart';
import 'package:df_ist_flutter/src/features/user/domain/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUser(int id);
}
