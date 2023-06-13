import 'package:dartz/dartz.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:graphql_demo/core/repositories/i_character_repository.dart';
import 'package:graphql_demo/infrastructure/datasources/remote_datasource/character_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ICharacterRepository)
class CharacterRepositoryImpl implements ICharacterRepository {
  const CharacterRepositoryImpl(this._characterRemoteDatasource);

  final CharacterRemoteDatasource _characterRemoteDatasource;

  @override
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination) {
    return _characterRemoteDatasource.getAllCharacters(pagination);
  }
}
