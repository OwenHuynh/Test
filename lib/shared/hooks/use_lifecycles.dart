import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Flutter lifecycle hook that call mount and unmount callbacks, when component
/// is mounted and un-mounted, respectively.
// ignore_for_file: exhaustive_keys, nested_hooks
void useLifecycles({VoidCallback? mount, VoidCallback? unmount}) {
  useEffect(() {
    mount?.call();
    return () => unmount?.call();
  }, const []);
}
