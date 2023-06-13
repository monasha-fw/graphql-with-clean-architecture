import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_character_dto.freezed.dart';

@freezed
class AddCharacterDto with _$AddCharacterDto {
  const factory AddCharacterDto({
    required String image,
    required String name,
  }) = _AddCharacterDto;
}
