import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:net_module/disposable_object.dart';
import 'package:net_module/interceptor/logging_interceptor.dart';
import 'package:net_module/interceptor/retry_interceptor.dart';
import 'package:net_module/models/bytes_response.dart';
import 'package:net_module/models/exceptions/api_exception.dart';
import 'package:net_module/models/exceptions/connectivity_exception.dart';
import 'package:net_module/models/exceptions/download_exception.dart';
import 'package:net_module/models/exceptions/http_service_exception.dart';
import 'package:net_module/models/exceptions/request_canceled_exception.dart';
import 'package:net_module/models/exceptions/response_mapping_exception.dart';
import 'package:net_module/models/exceptions/unexpected_status_code_exception.dart';
import 'package:net_module/models/request_base.dart';
import 'package:net_module/models/response_base.dart';
import 'package:net_module/options/http_service_options.dart';
import 'package:net_module/retrier/dio_connectivity_request_retrier.dart';

/// Handler function used for logging records. Function requires a single
/// [LogRecord] as the only parameter.
typedef LogHandlerFunction = void Function(LogRecord record);

final _levelEmojiMapper = {
  Level.INFO: 'ℹ️',
  Level.WARNING: '⚠️',
  Level.SEVERE: '🚨',
};

abstract class HttpServiceBase extends DisposableObject {
  HttpServiceBase({
    Level logLevel = Level.INFO,
    LogHandlerFunction? logHandlerFunction,
    Dio? dio,
    HttpServiceOptions? options,
    Logger? logger,
  }) {
    _logHandlerFunction = logHandlerFunction ?? _defaultLogHandler;
    _options = options ?? const HttpServiceOptions();
    _logLevel = logLevel;
    logger = logger ?? detachedLogger('-');
    dioInstance = dio ?? Dio()
      ..options.receiveTimeout = _options.receiveTimeout.inMilliseconds
      ..options.connectTimeout = _options.connectTimeout.inMilliseconds
      ..options.sendTimeout = _options.sendTimeout.inMilliseconds
      ..options.followRedirects = _options.followRedirects
      ..options.validateStatus = (status) {
        return status! < 500;
      }
      ..interceptors.addAll([
        if (logger.level != Level.OFF)
          LoggingInterceptor(
            requestHeader: true,
            logPrint: (step, message) {
              switch (step) {
                case InterceptStep.request:
                  return logger?.info('\x1B[36m${message}\x1B[0m');
                case InterceptStep.response:
                  return logger?.info('\x1B[32m${message}\x1B[0m');
                case InterceptStep.error:
                  return logger?.severe('\x1B[31m${message}\x1B[0m');
              }
            },
          ),
      ]);

    dioInstance.interceptors.add(RetryOnConnectionChangeInterceptor(
      requestRetrier: DioConnectivityRequestRetrier(
        dio: dioInstance,
        connectivity: Connectivity(),
      ),
    ));
  }

  late LogHandlerFunction _logHandlerFunction;

  LogHandlerFunction get _defaultLogHandler => (LogRecord record) {
        print(
          '${record.time} '
          '${_levelEmojiMapper[record.level] ?? record.level.name} '
          '${record.loggerName} ${record.message} ',
        );
        if (record.error != null) {
          print(record.error);
        }
        if (record.stackTrace != null) {
          print(record.stackTrace);
        }
      };

  Logger detachedLogger(String name) => Logger.detached(name)
    ..level = _logLevel
    ..onRecord.listen(_logHandlerFunction);

  /// Lock the current [HttpServiceBase] instance.
  ///
  /// [HttpServiceBase] will enqueue the incoming request tasks instead
  /// send them directly when [interceptor.requestOptions] is locked.
  // void lock() => dioInstance.lock();

  // /// Unlock the current [HttpServiceBase] instance.
  // ///
  // /// [HttpServiceBase] instance dequeue the request task。
  // void unlock() => dioInstance.unlock();

  // /// Clear the current [HttpServiceBase] instance waiting queue.
  // void clear() => dioInstance.clear();

  /// Shuts down the [HttpServiceBase].
  ///
  /// If [force] is `false` the [HttpServiceBase] will be kept alive
  /// until all active connections are done. If [force] is `true` any active
  /// connections will be closed to immediately release all resources. These
  /// closed connections will receive an error event to indicate that the client
  /// was shut down. In both cases trying to establish a new connection after
  /// calling [close] will throw an exception.
  void close({bool force = false}) => dioInstance.close(force: force);

// [Dio] httpClient
  /// It's been chosen because it's easy to use
  /// and supports interesting features out of the box
  /// (Interceptors, Global configuration, FormData, File downloading etc.)
  @visibleForTesting
  late final Dio dioInstance;

  /// Your project Stream Chat ClientOptions
  late final HttpServiceOptions _options;

  @protected
  List<CancelToken> cancelTokens = [];

  ///Get a token to attach to a request in order to dispose it later
  @protected
  CancelToken getNextToken() {
    final token = CancelToken();
    cancelTokens.add(token);
    return cancelTokens.last;
  }

  ///Clear all pending requests
  @protected
  void clearTokens() {
    for (final token in cancelTokens) {
      token.cancel();
    }
    cancelTokens.clear();
  }

  late final Level _logLevel;

  @override
  @mustCallSuper
  void disposeInstance() {
    clearTokens();
  }

  void _assertStatusCode(int expected, int actual) {
    if (expected != actual) {
      throw UnexpectedStatusCodeException(expected, actual);
    }
  }

  T _mapResponse<T extends ResponseBase>(
      Response response,
      T Function(Map<String, dynamic>, Response response)? mapper,
      T Function(dynamic, Response response)? orElse) {
    if (mapper != null && response.data is Map<String, dynamic>) {
      return mapper(response.data, response);
    } else {
      if (orElse != null) {
        return orElse(response.data, response);
      }
      throw Exception(
        'orElse mapping function must not be null for non json response.',
      );
    }
  }

  Future<T> _perform<T extends ResponseBase>(
    Future<Response> Function() performer,
    T Function(Map<String, dynamic>, Response response)? mapper,
    T Function(dynamic, Response response)? orElse,
    int expectedStatusCode,
    bool allowCache,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw ConnectivityException();
      }

      final response = await performer();
      if (!(allowCache && response.statusCode == 304)) {
        _assertStatusCode(expectedStatusCode, response.statusCode ?? -1);
      }
      return _mapResponse(response, mapper, orElse);
    } on DioError catch (error) {
      if (error.type == DioErrorType.cancel) {
        throw RequestCanceledException(error);
      }
      throw ApiException.fromDioError(error);
    } on HttpServiceException catch (_) {
      rethrow;
    } on Exception catch (e, s) {
      throw ResponseMappingException(e.toString(), s);
    }
  }

  /// Perform a query using the "GET" method.
  /// The query parameters are extracted from [request]
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip the [expectedStatusCode]
  /// check when the response
  /// is a cached one (HTTP code 304)
  @protected
  Future<T> getQuery<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.get(
        request.endpoint,
        queryParameters: request.toJson(),
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "POST" method.
  /// The body of the request is extracted from [request]'s [toData] method
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> postData<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.post(
        request.endpoint,
        data: request.toData(),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "POST" method and using the JSON content type
  /// The body of the request is extracted from [request]
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> postJson<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.post(
        request.endpoint,
        data: request.toJson(),
        queryParameters: queryParameters,
        options: options?.copyWith(
              contentType: 'application/json',
            ) ??
            Options(
              contentType: 'application/json',
            ),
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "DELETE" method.
  /// The body of the request is extracted from [request]'s [toData] method
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> deleteData<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.delete(
        request.endpoint,
        data: request.toData(),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "DELETE" method and using the JSON content type
  /// The body of the request is extracted from [request]
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> deleteJson<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.delete(
        request.endpoint,
        data: request.toJson(),
        queryParameters: queryParameters,
        options: options?.copyWith(contentType: 'application/json') ??
            Options(contentType: 'application/json'),
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "PUT" method.
  /// The body of the request is extracted from [request]'s [toData] method
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> putData<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.put(
        request.endpoint,
        data: request.toData(),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "PUT" method and using the JSON content type
  /// The body of the request is extracted from [request]
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> putJson<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.put(
        request.endpoint,
        data: request.toJson(),
        queryParameters: queryParameters,
        options: options?.copyWith(contentType: 'application/json') ??
            Options(contentType: 'application/json'),
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "PATCH" method.
  /// The body of the request is extracted from [request]'s [toData] method
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> patchData<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.patch(
        request.endpoint,
        data: request.toData(),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Perform a query using the "PATCH" method and using the JSON content type
  /// The body of the request is extracted from [request]
  /// Optionally pass [queryParameters] for query parameters
  /// attached to the request
  /// Use [mapper] to map the json response
  /// Optionally you can use the [orElse] to map other kind of response
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip che expectedStatusCode when response
  @protected
  Future<T> patchJson<T extends ResponseBase>({
    required RequestBase request,
    required T Function(Map<String, dynamic>, Response response) mapper,
    T Function(dynamic, Response response)? orElse,
    Options? options,
    bool cancelOnDispose = true,
    Map<String, dynamic> queryParameters = const {},
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response> performer() {
      return dioInstance.patch(
        request.endpoint,
        data: request.toJson(),
        queryParameters: queryParameters,
        options: options?.copyWith(contentType: 'application/json') ??
            Options(contentType: 'application/json'),
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(performer, mapper, orElse, expectedStatusCode, allowCache);
  }

  /// Downloads a file.
  /// The query parameters are extracted from [request]'s toJson
  /// Eventual additional data is extracter from [request]'s toData
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip the [expectedStatusCode]
  /// check when the response
  /// is a cached one (HTTP code 304)
  /// [onReceiveProgress] allows to know about the status of the download
  /// [deleteOnError] deletes the file if an error occurs
  @protected
  Future<void> download({
    required RequestBase request,
    required String path,
    Options? options,
    bool cancelOnDispose = true,
    int expectedStatusCode = 200,
    bool allowCache = true,
    bool deleteOnError = true,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    try {
      final response = await dioInstance.download(
        request.endpoint,
        path,
        queryParameters: request.toJson(),
        options: options,
        cancelToken: cancelOnDispose ? getNextToken() : null,
        deleteOnError: deleteOnError,
        onReceiveProgress: onReceiveProgress,
        data: request.toData(),
      );
      if (!(allowCache && response.statusCode == 304)) {
        _assertStatusCode(expectedStatusCode, response.statusCode ?? -1);
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.cancel) {
        throw RequestCanceledException(error);
      }
      throw ApiException.fromDioError(error);
    } on HttpServiceException catch (_) {
      rethrow;
    } on Exception catch (e, s) {
      throw DownloadException(e.toString(), s);
    }
  }

  /// Get bytes from an api.
  /// The query parameters are extracted from [request]
  /// Optionally you can specify [options] to pass to Dio
  /// [cancelOnDispose] lets you cancel the request if this service is disposed
  /// [expectedStatusCode] to check the result of the request
  /// set [allowCache] to `true` to skip the [expectedStatusCode]
  /// check when the response
  /// is a cached one (HTTP code 304)
  @protected
  Future<BytesResponse> getBytes({
    required RequestBase request,
    Options? options,
    bool cancelOnDispose = true,
    int expectedStatusCode = 200,
    bool allowCache = true,
  }) async {
    Future<Response<List<int>>> performer() {
      return dioInstance.get<List<int>>(
        request.endpoint,
        queryParameters: request.toJson(),
        options: options?.copyWith(responseType: ResponseType.bytes) ??
            Options(responseType: ResponseType.bytes),
        cancelToken: cancelOnDispose ? getNextToken() : null,
      );
    }

    return _perform(
      performer,
      null,
      (data, _) => BytesResponse(data),
      expectedStatusCode,
      allowCache,
    );
  }
}
