import 'package:dartz/dartz.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:graphql_demo/core/repositories/i_character_repository.dart';
import 'package:graphql_demo/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetAllCharacters implements Usecase<List<Character>, GetPagination> {
  final ICharacterRepository _repository;

  const GetAllCharacters(this._repository);

  @override
  Future<Either<Failure, List<Character>>> call(GetPagination pagination) async {
    return _repository.getAllCharacters(pagination);
  }
}
