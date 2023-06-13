import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:graphql_demo/core/dtos/character/add_character_dto.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/errors/network_failure.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:graphql_demo/infrastructure/constants/graphql_queries.dart';
import 'package:graphql_demo/infrastructure/models/characters/add_character_dto_model.dart';
import 'package:graphql_demo/infrastructure/models/characters/character_model.dart';
import 'package:graphql_demo/infrastructure/models/characters/characters_response_model.dart';
import 'package:graphql_demo/infrastructure/models/common/get_pagination_model.dart';
import 'package:graphql_demo/infrastructure/network/app_graphql_client.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRemoteDatasource {
  /// Get all characters
  ///
  /// [GetPagination] must contain, [page] number
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination);

  /// Add new character
  ///
  /// [AddCharacterDto] must contain all the required fields
  Future<Either<Failure, Unit>> addNewCharacter(AddCharacterDto dto);

  /// Listen to updates
  ///
  /// Will return a [Character] object right after the item is updated
  Stream<Either<Failure, Character>> listenToUpdates();
}

@Singleton(as: CharacterRemoteDatasource)
class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  /// Method 1
  // final GraphQLClient _client;

  /// Method 2 - This is more like clean with generic _client
  final AppGraphQlClient _client;

  const CharacterRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, List<Character>>> getAllCharacters(GetPagination pagination) async {
    try {
      /// Method 1
      // final options = GetPaginationModel.fromDomain(pagination)
      //     .toQueryOptions(GraphQlQueries.getAllCharactersQuery);
      // final QueryResult result = await _client.query(options);

      /// Method 2 - This is more like clean with generic _client
      final query = GetPaginationModel.fromDomain(pagination).toJson();
      final result =
          await _client.get(GraphQlQueries.getAllCharactersQuery, queryParameters: query);

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

  @override
  Future<Either<Failure, Unit>> addNewCharacter(AddCharacterDto dto) async {
    try {
      /// Method 1
      // final mutation =
      //     AddCharacterDtoModel.fromDomain(dto).toMutationOptions(GraphQlQueries.addCharacter);
      // final QueryResult result = await _client.mutate(mutation);

      /// Method 2 - This is more like clean with generic _client
      final data = AddCharacterDtoModel.fromDomain(dto).toJson();
      final result = await _client.post(GraphQlQueries.addCharacter, data: data);

      if (result.hasException) {
        return Left(
          Failure.networkFailure(NetworkFailure.unexpectedError(result.exception.toString())),
        );
      } else if (result.data == null) {
        return const Left(Failure.networkFailure(NetworkFailure.unexpectedError("No Data")));
      }

      return const Right(unit);
    } catch (e) {
      print("ERROR ==========> \n$e");
      return Left(Failure.networkFailure(NetworkFailure.unexpectedError(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, Character>> listenToUpdates() async* {
    try {
      var controller = StreamController<Either<Failure, Character>>();
      var stream = controller.stream;

      /// Method 1
      // final QueryResult result = await _client.mutate(mutation);

      /// Method 2 - This is more like clean with generic _client
      _client.subscription(GraphQlQueries.addCharacter).listen((QueryResult result) {
        if (result.hasException) {
          controller.add(Left(
            Failure.networkFailure(NetworkFailure.unexpectedError(result.exception.toString())),
          ));
        } else if (result.data == null) {
          controller.add(
            const Left(Failure.networkFailure(NetworkFailure.unexpectedError("No Data"))),
          );
        }

        final character = CharacterModel.fromJson(result.data!).toDomain();
        controller.add(Right(character));
      });

      yield* stream;
    } catch (e) {
      print("ERROR ==========> \n$e");
      yield Left(Failure.networkFailure(NetworkFailure.unexpectedError(e.toString())));
    }
  }
}
