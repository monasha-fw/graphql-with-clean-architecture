import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class ExternalLibraryInjectableModule {
  @lazySingleton
  GraphQLClient get graphQLClient {
    final httpLink = HttpLink('https://rickandmortyapi.com/graphql');
    return GraphQLClient(
      /// TODO The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: httpLink,
    );
  }

  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
