import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///  The interval can be paused by setting the delay to `null`.
void useInterval(
  VoidCallback callback, [
  Duration? delay = const Duration(milliseconds: 100),
]) {
  final savedCallback = useRef<VoidCallback>(() => {});

  useEffect(() {
    savedCallback.value = callback;
  });

  useEffect(() {
    if (delay != null) {
      final timer = Timer.periodic(delay, (time) {
        savedCallback.value();
      });
      return timer.cancel;
    }
    return null;
  }, [delay]);
}
