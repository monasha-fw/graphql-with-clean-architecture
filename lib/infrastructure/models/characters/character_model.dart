import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
  const CharacterModel._();

  const factory CharacterModel({
    required String id,
    required String image,
    required String name,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

  Character toDomain() {
    // TODO - change to value objects
    return Character(id: id, name: name, image: image);
  }
}
