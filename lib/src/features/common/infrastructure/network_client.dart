import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/logging_service.dart';

typedef JsonMap = Map<String, dynamic>;

class NetworkClient {
  NetworkClient(
    this.logger, {
    Dio? dio,
  }) : _dio = dio ?? Dio();

  final LoggingService logger;
  final Dio _dio;

  Future<TResult?> get<TParsed, TResult>(
    Uri uri, {
    required TResult Function(TParsed e) transform,
    void Function(AppException e)? onError,
    VoidCallback? onBegin,
    VoidCallback? onEnd,
  }) async {
    return performFetch(
      RequestOptions(
        path: uri.path,
        method: 'GET',
        baseUrl: uri.origin,
        queryParameters: uri.queryParameters,
      ),
      transform: transform,
      onError: onError,
      onBegin: onBegin,
      onEnd: onEnd,
    );
  }

  Future<TResult?> performFetch<TParsed, TResult>(
    RequestOptions requestOptions, {
    required TResult Function(TParsed e) transform,
    void Function(AppException e)? onError,
    VoidCallback? onBegin,
    VoidCallback? onEnd,
  }) async {
    final localErrorHandler = onError ??
        (e) => logger.error(runtimeType, AppException.getErrorMessage(e));

    void errorHandler(AppException e) {
      onEnd?.call();
      localErrorHandler(e);
    }

    onBegin?.call();
    try {
      final result = await _dio.fetch<dynamic>(requestOptions);
      onEnd?.call();
      final parsed = result.data as TParsed;
      if (parsed == null) return null;
      return transform.call(parsed);
    } on AppException catch (e) {
      errorHandler(e);
    } catch (e) {
      errorHandler(AppException.getAppException(e));
    }

    return null;
  }
}
