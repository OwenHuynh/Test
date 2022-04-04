import 'package:portal/shared/hooks/use_first_mount_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// previous distinct value
T? usePreviousDistinct<T>(T value, [Predicate<T>? compare]) {
  compare ??= (prev, next) => prev == next;
  final prevRef = useRef<T?>(null);
  final curRef = useRef<T>(value);
  final isFirstMount = useFirstMountState();

  if (!isFirstMount && !compare(curRef.value, value)) {
    prevRef.value = curRef.value;
    curRef.value = value;
  }

  return prevRef.value;
}

typedef Predicate<T> = bool Function(T prev, T next);
