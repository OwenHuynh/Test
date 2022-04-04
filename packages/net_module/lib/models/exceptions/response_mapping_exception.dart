import 'package:net_module/models/exceptions/http_service_exception.dart';

///Thrown when something bad occurs while mapping the response
class ResponseMappingException extends HttpServiceException {
  ResponseMappingException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$message\n\n$stackTrace';
  }
}
