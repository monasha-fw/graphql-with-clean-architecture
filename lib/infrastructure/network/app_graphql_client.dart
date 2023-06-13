import 'dart:io';

import 'package:graphql/client.dart';
import 'package:graphql_demo/i18n/translations.g.dart';
import 'package:graphql_demo/infrastructure/network/i_http_client.dart';
import 'package:injectable/injectable.dart';

import 'network_info.dart';

@singleton
class AppGraphQlClient<T> implements IHttpClient {
  final GraphQLClient _client;
  final INetworkInfo _networkInfo;

  const AppGraphQlClient(this._client, this._networkInfo);

  /// internet connectivity check
  Future<void> _checkInternetConnectivity() async {
    if (!(await _networkInfo.isConnected)) throw SocketException(t.errors.noInternet);
  }

  @override
  Future<QueryResult> get(String uri, {Map<String, dynamic>? queryParameters}) async {
    await _checkInternetConnectivity();

    final QueryOptions options = QueryOptions(
      document: gql(uri),
      variables: queryParameters ?? {},
    );
    return _client.query(options);
  }

  @override
  Future<QueryResult> post(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _checkInternetConnectivity();

    final MutationOptions options = MutationOptions(
      document: gql(uri),
      variables: {...(data ?? {}), ...(queryParameters ?? {})},
    );
    return _client.mutate(options);
  }

  @override
  Future<QueryResult> delete(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return post(uri, data: data, queryParameters: queryParameters);
  }

  @override
  Future<QueryResult> patch(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return post(uri, data: data, queryParameters: queryParameters);
  }

  @override
  Future<QueryResult> put(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return post(uri, data: data, queryParameters: queryParameters);
  }

  /// Specific to `GraphQL`
  Stream<QueryResult<T>> subscription(String uri) {
    final options = SubscriptionOptions<T>(document: gql(uri));
    return _client.subscribe<T>(options);
  }
}
