import 'package:portal/shared/hooks/use_first_mount_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Flutter effect hook that ignores the first invocation (e.g. on mount).
/// The signature is exactly the same as the useEffect hook.
// ignore_for_file: exhaustive_keys, nested_hooks
void useUpdateEffect(Dispose? Function() effect, [List<Object?>? keys]) {
  final isFirstMount = useFirstMountState();

  useEffect(() {
    if (!isFirstMount) {
      return effect();
    }
  }, keys);
}
