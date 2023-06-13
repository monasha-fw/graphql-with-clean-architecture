import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/errors/network_failure.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:graphql_demo/infrastructure/constants/graphql_queries.dart';
import 'package:graphql_demo/infrastructure/models/characters/characters_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRemoteDatasource {
  /// Get all characters
  ///
  /// [GetPagination] must contain, [page] number
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination);
}

const int nRepositories = 50;

@Singleton(as: CharacterRemoteDatasource)
class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final GraphQLClient _client;

  const CharacterRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(GraphQlQueries.getAllCharactersQuery),
        variables: <String, dynamic>{
          'page': pagination.page,
        },
      );

      final QueryResult result = await _client.query(options);

      if (result.hasException) {
        return Left(
          Failure.networkFailure(NetworkFailure.unexpectedError(result.exception.toString())),
        );
      } else if (result.data == null) {
        return const Left(Failure.networkFailure(NetworkFailure.unexpectedError("No Data")));
      }

      final charactersResponse = CharactersResponseModel.fromJson(result.data!);
      final list = charactersResponse.characters.results.map((c) => c.toDomain()).toList();
      return Right(list);
    } catch (e) {
      print("ERROR ==========> \n$e");
      return Left(Failure.networkFailure(NetworkFailure.unexpectedError(e.toString())));
    }
  }
}
