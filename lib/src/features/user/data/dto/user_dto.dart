import 'package:df_ist_flutter/src/features/user/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  UserModel toModel() => UserModel(id: id, firstName: firstName, lastName: lastName, email: email);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
