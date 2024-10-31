import 'package:df_ist_flutter/src/features/user/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String name;
  final String email;

  UserDto({required this.id, required this.name, required this.email});

  UserModel toModel() => UserModel(id: id, name: name, email: email);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
