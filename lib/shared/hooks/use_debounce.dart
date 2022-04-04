import 'package:flutter/foundation.dart';
import 'package:portal/shared/hooks/use_timeout_fn.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// ignore_for_file: exhaustive_keys, nested_hooks
void useDebounce(VoidCallback fn, Duration delay, [List<Object?>? keys]) {
  final timeout = useTimeoutFn(fn, delay);
  useEffect(() => timeout.reset, keys);
}
