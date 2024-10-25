import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

sealed class AppException implements Exception {
  @pragma('vm:entry-point')
  const AppException();

  static const defaultMessage = 'Unexpected error occurred.';

  static AppException getAppException(dynamic error) {
    if (error is Exception) {
      try {
        AppException networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = RequestCancelled();
            case DioExceptionType.connectionTimeout:
              networkExceptions = RequestTimeout();
            case DioExceptionType.unknown:
              networkExceptions = NoInternetConnection();
            case DioExceptionType.receiveTimeout:
              networkExceptions = SendTimeout();
            case DioExceptionType.sendTimeout:
              networkExceptions = SendTimeout();
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  networkExceptions = InvalidRequest();
                case 401:
                  networkExceptions = IncorrectAuthRequest();
                case 403:
                  networkExceptions = UnauthorisedRequest();
                case 404:
                  networkExceptions = const NotFound('Not found');
                case 409:
                  networkExceptions = Conflict();
                case 408:
                  networkExceptions = RequestTimeout();
                case 500:
                  networkExceptions = InternalServerError();
                case 503:
                  networkExceptions = ServiceUnavailable();
                default:
                  final responseCode = error.response!.statusCode;
                  networkExceptions = DefaultError(
                    'Received invalid status code: $responseCode',
                  );
              }
            case DioExceptionType.connectionError:
            case DioExceptionType.badCertificate:
              networkExceptions = UnexpectedError();
          }
        } else if (error is SocketException) {
          networkExceptions = NoInternetConnection();
        } else if (error is HttpException) {
          networkExceptions = const NotFound('Resource not found.');
        } else {
          networkExceptions = UnexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return FormatException();
      } on PlatformException catch (e) {
        AppException networkExceptions;
        switch (e.code) {
          case 'sign_in_canceled':
            networkExceptions = const DefaultError('Sign in cancelled');

          case 'network_error':
            networkExceptions = NoInternetConnection();

          case 'sign_in_failed':
            networkExceptions = const DefaultError('Sign in failed');

          default:
            networkExceptions = DefaultError(e.message ?? defaultMessage);
            break;
        }
        return networkExceptions;
      } catch (_) {
        return UnexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return UnableToProcess();
      } else {
        return UnexpectedError();
      }
    }
  }

  static String getErrorMessage(AppException customExceptions) {
    var errorMessage = '';
    switch (customExceptions) {
      case RequestCancelled():
        errorMessage = 'Request Cancelled.';
      case UnauthorisedRequest():
        errorMessage = 'Unauthorised request.';
      case IncorrectAuthRequest():
        errorMessage = 'Unauthorised: Invalid login credentials.';
      case InvalidRequest():
        errorMessage = 'Invalid details provided.';
      case NotFound(reason: final reason):
        errorMessage = reason;
      case RequestTimeout():
        errorMessage = 'Connection request timeout.';
      case SendTimeout():
        errorMessage = 'Send timeout in connection with API server.';
      case Conflict():
        errorMessage = 'Error due to a conflict.';
      case InternalServerError():
        errorMessage = 'Internal Server Error.';
      case ServiceUnavailable():
        errorMessage = 'Service unavailable.';
      case NoInternetConnection():
        errorMessage = 'Check your internet connection.';
      case FormatException():
        errorMessage = defaultMessage;
      case UnableToProcess():
        errorMessage = 'Unable to process the data.';
      case DefaultError(error: final error):
        errorMessage = error ?? defaultMessage;
      case UnexpectedError():
        errorMessage = defaultMessage;
    }
    return errorMessage;
  }
}

class RequestCancelled extends AppException {}

class UnauthorisedRequest extends AppException {}

class IncorrectAuthRequest extends AppException {}

class InvalidRequest extends AppException {}

class NotFound extends AppException {
  const NotFound(this.reason);

  final String reason;
}

class RequestTimeout extends AppException {}

class SendTimeout extends AppException {}

class Conflict extends AppException {}

class InternalServerError extends AppException {}

class ServiceUnavailable extends AppException {}

class NoInternetConnection extends AppException {}

class FormatException extends AppException {}

class UnableToProcess extends AppException {}

class DefaultError extends AppException {
  const DefaultError(this.error);

  final String? error;
}

class UnexpectedError extends AppException {}
