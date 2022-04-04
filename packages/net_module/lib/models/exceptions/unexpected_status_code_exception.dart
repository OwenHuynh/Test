import 'package:net_module/models/exceptions/http_service_exception.dart';

///Thrown when expected HTTP code doesn't match the received one.
///[expected] is the expected status code
///[actual] is the received status code
class UnexpectedStatusCodeException extends HttpServiceException {
  UnexpectedStatusCodeException(this.expected, this.actual);

  final int expected;
  final int actual;
}
