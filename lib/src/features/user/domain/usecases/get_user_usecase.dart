import 'package:dartz/dartz.dart';
import 'package:df_ist_flutter/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

@injectable
class GetUserUsecase {
  final UserRepository repository;

  GetUserUsecase(this.repository);

  Future<Either<Failure, UserModel>> call(int id) async {
    return await repository.getUser(id);
  }
}
