import 'package:net_module/models/exceptions/http_service_exception.dart';

///Thrown when something bad occurs with the file download
class DownloadException extends HttpServiceException {
  DownloadException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
