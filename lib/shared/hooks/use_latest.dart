import 'package:flutter_hooks/flutter_hooks.dart';

/// React state hook that returns the latest state as described in
T useLatest<T>(T value) {
  final ref = useRef(value)..value = value;
  return ref.value;
}
