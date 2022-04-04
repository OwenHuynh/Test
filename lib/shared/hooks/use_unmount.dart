import 'package:flutter/foundation.dart';
import 'package:portal/shared/hooks/use_effect_once.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Flutter lifecycle hook that calls a function when the component will
/// unmount. Use useLifecycles if you need both a mount and unmount function.
void useUnmount(VoidCallback fn) {
  final fnRef = useRef(fn)..value = fn;

  return useEffectOnce(() => () => fnRef.value());
}
