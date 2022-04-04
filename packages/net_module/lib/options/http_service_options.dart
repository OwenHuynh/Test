import 'package:dio/dio.dart';

/// Client options to modify [HttpServiceOptions]
class HttpServiceOptions {
  /// Instantiates a new [HttpServiceOptions]
  const HttpServiceOptions(
      {String? baseUrl,
      this.connectTimeout = const Duration(seconds: 10),
      this.receiveTimeout = const Duration(seconds: 10),
      this.sendTimeout = const Duration(seconds: 10),
      this.queryParameters = const {},
      this.headers = const {},
      this.responseType = ResponseType.json,
      this.contentType,
      this.validateStatus,
      this.receiveDataWhenStatusError,
      this.followRedirects = false,
      this.maxRedirects})
      : baseUrl = baseUrl ?? '';

  /// base url to use with client.
  final String baseUrl;

  /// connect timeout, default to 6s
  final Duration connectTimeout;

  /// received timeout, default to 6s
  final Duration receiveTimeout;

  /// send timeout, default to 6s
  final Duration sendTimeout;

  /// Common query parameters.
  final Map<String, Object?> queryParameters;

  /// Http request headers.
  final Map<String, Object?> headers;

  /// Response Type
  final ResponseType? responseType;

  /// Content Type.
  final String? contentType;

  /// Validate Status.
  final ValidateStatus? validateStatus;

  /// Receive Data When Status Error.
  final bool? receiveDataWhenStatusError;

  /// Follow Redirects.
  final bool followRedirects;

  /// Max Redirects.
  final int? maxRedirects;
}
