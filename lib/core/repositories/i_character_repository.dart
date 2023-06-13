import 'package:dartz/dartz.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';

abstract class ICharacterRepository {
  /// Get all characters
  ///
  /// [GetPagination] must contain, [page] number
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination);
}
