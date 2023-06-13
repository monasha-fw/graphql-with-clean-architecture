import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/i18n/translations.g.dart';

extension FailuresMapper on Failure {
  String get getMessage => map(
        authFailure: (af) => af.f.map(
          tokenExpired: (_) => t.errors.authFailures.tokenExpired,
        ),
        unexpectedError: (sf) => sf.message,
        cacheFailure: (cf) => cf.f.map(
          cacheClearFailure: (f) => f.message ?? t.errors.cacheFailure,
          cacheSetFailure: (f) => f.message ?? t.errors.cacheFailure,
          cacheGetFailure: (f) => f.message ?? t.errors.cacheFailure,
        ),
        networkFailure: (nf) => nf.f.map(
          // TODO - Add rest of error messages to translations
          requestCancelled: (f) => t.errors.somethingWentWrong,
          unauthorisedRequest: (f) => f.errorMessage ?? t.errors.unauthorized,
          badRequest: (f) => t.errors.somethingWentWrong,
          notFound: (f) => f.error.toString(),
          methodNotAllowed: (f) => t.errors.somethingWentWrong,
          notAcceptable: (f) => t.errors.somethingWentWrong,
          requestTimeout: (f) => t.errors.somethingWentWrong,
          conflict: (f) => t.errors.somethingWentWrong,
          internalServerError: (f) => t.errors.somethingWentWrong,
          notImplemented: (f) => t.errors.somethingWentWrong,
          serviceUnavailable: (f) => t.errors.somethingWentWrong,
          connectionRefused: (f) => t.errors.somethingWentWrong,
          noInternetConnection: (f) => t.errors.somethingWentWrong,
          defaultError: (f) => f.error,
          unexpectedError: (f) => f.data.toString(),
          badCertificate: (f) => t.errors.somethingWentWrong,
          badResponse: (f) => t.errors.somethingWentWrong,
          connectionError: (f) => t.errors.somethingWentWrong,
        ),
        ignoringFailure: (_) => "",
        formatException: (fe) => fe.exception.message,
        unableToProcess: (uf) => uf.error,
      );
}
