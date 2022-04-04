import 'package:dio/dio.dart';
import 'package:net_module/models/exceptions/http_service_exception.dart';

///Thrown when a request is canceled
class RequestCanceledException extends HttpServiceException {
  RequestCanceledException(this.error);

  final DioError error;
}
