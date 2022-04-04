import 'package:portal/shared/hooks/use_timeout_fn.dart';
import 'package:portal/shared/hooks/use_update.dart';

/// Provides handles to cancel and/or reset the timeout.
TimeoutState useTimeout(Duration delay) {
  final update = useUpdate();
  return useTimeoutFn(update, delay);
}
