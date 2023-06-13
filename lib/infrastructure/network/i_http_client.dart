abstract class IHttpClient {
  /// Http method for [GET] request
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [POST] request
  Future<dynamic> post(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [PATCH] request
  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [PUT] request
  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [DELETE] request
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });
}
