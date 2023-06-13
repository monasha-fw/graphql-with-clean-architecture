import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_demo/core/errors/error.dart';
import 'package:graphql_demo/core/errors/failures.dart';
import 'package:graphql_demo/core/errors/network_failure.dart';
import 'package:graphql_demo/i18n/translations.g.dart';

part 'app_exceptions.freezed.dart';

@freezed
class AppExceptions with _$AppExceptions {
  const AppExceptions._();

  const factory AppExceptions() = _AppExceptions;

  static Failure exceptionToFailure(error) {
    log("[FAILURE] $error");
    if (error is UnexpectedValueError) {
      return Failure.unableToProcess(
        error.valueFailure.failedValue?.toString() ?? t.errors.somethingWentWrong,
      );
    } else if (error is PlatformException) {
      return _getPlatformException(error);
    } else if (error is Exception) {
      try {
        return Failure.networkFailure(_getDioException(error));
      } on FormatException catch (e) {
        return Failure.formatException(e);
      } catch (ex) {
        return Failure.unexpectedError(ex.toString());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return Failure.unableToProcess(error.toString());
      } else {
        return Failure.unexpectedError(error);
      }
    }
  }

  static Failure _getPlatformException(error) {
    late Failure failure;
    switch (error.code) {
      // case "sign_in_failed":
      //   failure = Failure.authFailure(AuthFailure.somethingWentWrong(message: t.errors.failures.auth.googleSignIn));
      //   break;
      default:
        failure = Failure.unexpectedError(error);
    }
    return failure;
  }

  static NetworkFailure _getDioException(error) {
    late NetworkFailure networkFailure;
    // if (error is DioException) { // TODO GraphQL exceptions
    //
    // } else
    if (error is SocketException) {
      networkFailure = const NetworkFailure.noInternetConnection();
    } else {
      networkFailure = NetworkFailure.unexpectedError(error);
    }
    return networkFailure;
  }
}
