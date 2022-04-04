import 'package:portal/shared/hooks/hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock.dart';
import '../utils/flutter_hooks_testing.dart';

void main() {
  group('useEffectOnce', () {
    testWidgets('should run provided effect only once', (tester) async {
      final effect = MockEffect();
      final result = await buildHook(
        (_) => useEffectOnce(effect),
      );
      verify(effect).called(1);
      await result.rebuild();
      verifyNever(effect);
      verifyNoMoreInteractions(effect);
    });

    testWidgets('should run dispose only once after unmount', (tester) async {
      final dispose = MockDispose();
      final result = await buildHook(
        (_) => useEffectOnce(() {
          return dispose;
        }),
      );
      await result.unmount();
      verify(dispose).called(1);
      verifyNoMoreInteractions(dispose);
    });
  });
}
