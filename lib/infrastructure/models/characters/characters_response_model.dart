import 'package:freezed_annotation/freezed_annotation.dart';

import 'character_model.dart';

part 'characters_response_model.freezed.dart';
part 'characters_response_model.g.dart';

@freezed
class CharactersResponseModel with _$CharactersResponseModel {
  const factory CharactersResponseModel({
    required CharactersModel characters,
  }) = _CharactersResponseModel;

  factory CharactersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CharactersResponseModelFromJson(json);
}

@freezed
class CharactersModel with _$CharactersModel {
  const factory CharactersModel({
    required CharactersInfoModel info,
    required List<CharacterModel> results,
  }) = _CharactersModel;

  factory CharactersModel.fromJson(Map<String, dynamic> json) => _$CharactersModelFromJson(json);
}

@freezed
class CharactersInfoModel with _$CharactersInfoModel {
  const factory CharactersInfoModel({
    required int count,
    required int? next,
    required int pages,
    required int? prev,
  }) = _CharactersInfoModel;

  factory CharactersInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CharactersInfoModelFromJson(json);
}
