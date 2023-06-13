import 'package:dartz/dartz.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRemoteDatasource {
  /// Get all characters
  ///
  /// [GetPagination] must contain, [page] number
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination);
}

@Singleton(as: CharacterRemoteDatasource)
class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  @override
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination) {
    // TODO: implement getCars
    throw UnimplementedError();
  }
}
