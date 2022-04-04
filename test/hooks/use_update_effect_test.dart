import 'package:portal/shared/hooks/use_update_effect.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock.dart';
import '../utils/flutter_hooks_testing.dart';

void main() {
  group('useUpdateEffect', () {
    testWidgets('should run effect on update', (tester) async {
      final effect = MockDispose();
      final result = await buildHook((_) {
        useUpdateEffect(() {
          effect();

          return null;
        });
      });
      verifyNever(effect);
      await result.rebuild();
      verify(effect).called(1);
    });
    testWidgets('should run cleanup on unmount', (tester) async {
      final dispose = MockDispose();
      final result = await buildHook((_) {
        useUpdateEffect(() {
          return dispose;
        });
      });
      await result.rebuild();
      await result.unmount();
      verify(dispose).called(1);
    });
  });
}
