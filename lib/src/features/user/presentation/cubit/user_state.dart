import 'package:df_ist_flutter/src/features/user/domain/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserModel user) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
