import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Returns an error dispatcher.
// ignore_for_file: exhaustive_keys, nested_hooks
ErrorState useError() {
  final error = useState<Error?>(null);
  final dispatcher = useCallback<void Function(Error e)>((e) {
    error.value = e;
  }, const []);

  final getter = useCallback<Error? Function()>(() {
    return error.value;
  }, const []);
  final state = useRef(ErrorState(dispatcher, getter));

  return state.value;
}

@immutable
class ErrorState {
  const ErrorState(this._dispatcher, this._getter);

  final Error? Function() _getter;
  final void Function(Error e) _dispatcher;

  void dispatch(Error e) => _dispatcher(e);

  Error? get value => _getter();
}
