import 'package:net_module/net_module.dart';

class AsyncActionListener {
  AsyncActionListener(
      {required this.onStart, required this.onSuccess, required this.onError});

  final Function() onStart;

  void Function() onSuccess;

  void Function(HttpServiceException error) onError;
}

class AsyncActionCompleteWithDataListener<T> {
  AsyncActionCompleteWithDataListener(
      {required this.onStart, required this.onSuccess, required this.onError});

  final Function() onStart;

  void Function(T data) onSuccess;

  void Function(HttpServiceException error) onError;
}
