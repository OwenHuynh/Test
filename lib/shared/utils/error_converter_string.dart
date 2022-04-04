import 'package:flutter/cupertino.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';
import 'package:net_module/net_module.dart';

class ErrorConverterString {
  static String parseError(BuildContext context,
      {required HttpServiceException error}) {
    switch (error.runtimeType) {
      case ConnectivityException:
        return Localy.of(context)!.connectError;
      case DownloadException:
        return Localy.of(context)!.networkError;
      case RequestCanceledException:
        return Localy.of(context)!.cancelError;
      case ResponseMappingException:
        return Localy.of(context)!.parseError;
      case SocketException:
        return Localy.of(context)!.networkError;
      case UnexpectedStatusCodeException:
        return _parseUnexpectedStatusCodeException(context,
            error: error as UnexpectedStatusCodeException);
      default:
        return Localy.of(context)!.networkError;
    }
  }

  static String _parseUnexpectedStatusCodeException(BuildContext context,
      {required UnexpectedStatusCodeException error}) {
    switch (error.actual) {
      case 400:
        return Localy.of(context)!.badRequestError;
      case 401:
        return Localy.of(context)!.unauthorizedError;
      case 403:
        return Localy.of(context)!.forbiddenError;
      default:
        return Localy.of(context)!.networkError;
    }
  }
}
