import 'package:bloc/bloc.dart';
import 'package:df_ist_flutter/src/core/di/locator.dart';
import 'package:df_ist_flutter/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:df_ist_flutter/src/features/user/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUsecase _getUserUsecase;

  UserCubit(GetUserUsecase? getUserUsecase)
      : _getUserUsecase = getUserUsecase ?? getIt<GetUserUsecase>(),
        super(const UserState.initial());

  Future<void> getUser(int id) async {
    emit(const UserState.loading());

    final result = await _getUserUsecase(id);
    result.fold(
      (failure) => emit(UserState.error(failure.message)),
      (user) => emit(UserState.loaded(user)),
    );
  }
}
