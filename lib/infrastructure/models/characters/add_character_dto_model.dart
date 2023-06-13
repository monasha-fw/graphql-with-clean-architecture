import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart' as graph;
import 'package:graphql_demo/core/dtos/character/add_character_dto.dart';

part 'add_character_dto_model.freezed.dart';
part 'add_character_dto_model.g.dart';

@freezed
class AddCharacterDtoModel with _$AddCharacterDtoModel {
  const AddCharacterDtoModel._();

  const factory AddCharacterDtoModel({
    required String image,
    required String name,
  }) = _AddCharacterDtoModel;

  factory AddCharacterDtoModel.fromJson(Map<String, dynamic> json) =>
      _$AddCharacterDtoModelFromJson(json);

  factory AddCharacterDtoModel.fromDomain(AddCharacterDto dto) {
    return AddCharacterDtoModel(image: dto.image, name: dto.name);
  }

  graph.MutationOptions toMutationOptions(String document) {
    return graph.MutationOptions(
      document: graph.gql(document),
      variables: <String, dynamic>{
        'image': image,
        "name": name,
      },
    );
  }
}
